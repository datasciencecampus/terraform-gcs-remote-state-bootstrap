// Terraform module for remote state bucket with CMEK and logging bucket

locals {
  labels = merge(
    {
      module = "datasciencecampus/terraform-gcs-remote-state-bootstrap"
    },
    var.labels
  )
}

terraform {
  required_version = ">= 1.6.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.bucket_location
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring
resource "google_kms_key_ring" "state" {
  name     = var.kms_key_ring_name
  location = var.kms_location
  project  = var.project_id
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key
resource "google_kms_crypto_key" "state" {
  name            = var.kms_crypto_key_name
  key_ring        = google_kms_key_ring.state.id
  rotation_period = "100000s"

  lifecycle {
    prevent_destroy = true
  }
}


# https://registry.terraform.io/providers/hashicorp/google/7.23.0/docs/resources/storage_bucket#argument-reference
resource "google_storage_bucket" "state" {
  name     = var.state_bucket_name
  location = var.bucket_location
  project  = var.project_id

  force_destroy               = var.force_destroy
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  labels = local.labels

  encryption {
    default_kms_key_name = google_kms_crypto_key.state.id
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      num_newer_versions = var.state_bucket_version_retention_count
    }
  }

  logging {
    log_bucket        = google_storage_bucket.logging.name
    log_object_prefix = "state-bucket-logs/"
  }
  depends_on = [google_storage_bucket.logging]
}


# https://registry.terraform.io/providers/hashicorp/google/7.23.0/docs/resources/storage_bucket#argument-reference
resource "google_storage_bucket" "logging" {
  #checkov:skip=CKV_GCP_62: Logging is not enabled for the logging bucket itself to avoid recursive log generation and unnecessary storage costs.
  name     = var.logging_bucket_name
  location = var.bucket_location
  project  = var.project_id

  force_destroy               = var.force_destroy
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  encryption {
    default_kms_key_name = google_kms_crypto_key.state.id
  }

  labels = local.labels

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = var.logging_bucket_retention_days
    }
  }

  versioning {
    enabled = true
  }

}

# IAM roles for state bucket
resource "google_storage_bucket_iam_member" "state_viewer" {
  bucket = google_storage_bucket.state.name
  role   = "roles/storage.objectViewer"
  member = var.storage_object_viewer_principal
}

resource "google_storage_bucket_iam_member" "state_admin" {
  bucket = google_storage_bucket.state.name
  role   = "roles/storage.objectAdmin"
  member = var.storage_object_admin_principal
}

# IAM roles for logging bucket
resource "google_storage_bucket_iam_member" "logging_viewer" {
  bucket = google_storage_bucket.logging.name
  role   = "roles/storage.objectViewer"
  member = var.storage_object_viewer_principal
}

resource "google_storage_bucket_iam_member" "logging_admin" {
  bucket = google_storage_bucket.logging.name
  role   = "roles/storage.objectAdmin"
  member = var.storage_object_admin_principal
}
