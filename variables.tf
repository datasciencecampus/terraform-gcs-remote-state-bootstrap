variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "state_bucket_name_override" {
  description = "Name of the remote state bucket."
  type        = string
  default     = ""
}

variable "logging_bucket_name_override" {
  description = "Name of the logging bucket."
  type        = string
  default     = ""
}

variable "bucket_location" {
  description = "Location for the buckets."
  type        = string
  default     = "europe-west2"
}

variable "kms_key_ring_name_override" {
  description = "Name of the KMS key ring."
  type        = string
  default     = ""
}

variable "kms_crypto_key_name_override" {
  description = "Name of the KMS crypto key."
  type        = string
  default     = ""
}

variable "kms_location" {
  description = "Location for the KMS key ring."
  type        = string
  default     = "europe-west2"
}

variable "state_bucket_version_retention_count" {
  description = "Number of newer versions to retain in the state bucket before older versions are automatically deleted."
  type        = number
  default     = 5
}


variable "storage_object_viewer_principal" {
  description = <<EOT
The principal to be granted the Storage Object Viewer role on the state bucket. Must be a valid IAM principal string, e.g.:
  - user:someone@example.com
  - group:admins@example.com
  - serviceAccount:my-sa@project.iam.gserviceaccount.com
  - domain:example.com
EOT
  type        = string
  validation {
    condition     = can(regex("^(user|group|serviceAccount|domain):[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$|^domain:[A-Za-z0-9.-]+$", var.storage_object_viewer_principal))
    error_message = "Principal must be a valid IAM principal string (user, group, serviceAccount, or domain)."
  }
}

variable "storage_object_admin_principal" {
  description = <<EOT
The principal to be granted the Storage Object Admin role on the state bucket. Must be a valid IAM principal string, e.g.:
  - user:someone@example.com
  - group:admins@example.com
  - serviceAccount:my-sa@project.iam.gserviceaccount.com
  - domain:example.com
EOT
  type        = string
  validation {
    condition     = can(regex("^(user|group|serviceAccount|domain):[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$|^domain:[A-Za-z0-9.-]+$", var.storage_object_admin_principal))
    error_message = "Principal must be a valid IAM principal string (user, group, serviceAccount, or domain)."
  }
}

variable "force_destroy" {
  description = "Whether to force destroy the buckets (deleting all objects). Use with caution."
  type        = bool
  default     = false
}

variable "logging_bucket_retention_days" {
  description = "Number of days to retain objects in the logging bucket before automatic deletion."
  type        = number
  default     = 30
}

variable "labels" {
  description = "A map of labels to apply to the buckets."
  type        = map(string)
  default     = {}
}
