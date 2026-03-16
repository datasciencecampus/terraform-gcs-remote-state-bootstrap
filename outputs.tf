output "state_bucket_name" {
  description = "The name of the remote state bucket."
  value       = google_storage_bucket.state.name
}

output "logging_bucket_name" {
  description = "The name of the logging bucket."
  value       = google_storage_bucket.logging.name
}

output "kms_key_ring_id" {
  description = "The ID of the KMS key ring."
  value       = google_kms_key_ring.state.id
}

output "kms_crypto_key_id" {
  description = "The ID of the KMS crypto key."
  value       = google_kms_crypto_key.state.id
}
