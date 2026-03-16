output "state_bucket_name" {
  description = "The name of the remote state bucket."
  value       = google_storage_bucket.state.name
}

output "logging_bucket_name" {
  description = "The name of the logging bucket."
  value       = google_storage_bucket.logging.name
}
