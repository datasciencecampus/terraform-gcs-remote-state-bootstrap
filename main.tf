// Terraform module for remote state bucket with CMEK and logging bucket

data "google_project" "current" {
  project_id = var.project_id
}

locals {
  labels = merge(
    {
      module = "terraform-gcs-remote-state-bootstrap"
    },
    var.labels
  )
  remote_state_bucket_name = var.state_bucket_name_override != "" ? var.state_bucket_name_override : "state__${data.google_project.current.number}"
  logging_bucket_name      = var.logging_bucket_name_override != "" ? var.logging_bucket_name_override : "logging__${data.google_project.current.number}"
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

# https://registry.terraform.io/providers/hashicorp/google/7.23.0/docs/resources/storage_bucket#argument-reference
resource "google_storage_bucket" "state" {
  name     = local.remote_state_bucket_name
  location = var.bucket_location
  project  = var.project_id

  force_destroy               = var.force_destroy
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  labels = local.labels

  encryption {
    default_kms_key_name = var.kms_key_resource_name
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
  name     = local.logging_bucket_name
  location = var.bucket_location
  project  = var.project_id

  force_destroy               = var.force_destroy
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  encryption {
    default_kms_key_name = var.kms_key_resource_name
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

# Grant Cloud Storage service account access to KMS key
resource "google_kms_crypto_key_iam_member" "storage_service_account" {
  crypto_key_id = var.kms_key_resource_name
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "service-${data.google_project.current.number}@gs-project-accounts.iam.gserviceaccount.com"
}
