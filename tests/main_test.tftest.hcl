test {
  parallel = true
}

variables {
  project_id                           = "my-gcp-project"
  bucket_location                      = "europe-west2"
  kms_key_ring_name                    = "my-key-ring"
  kms_crypto_key_name                  = "my-crypto-key"
  kms_location                         = "europe-west2"
  state_bucket_name                    = "my-state-bucket"
  logging_bucket_name                  = "my-logging-bucket"
  state_bucket_version_retention_count = 5
  logging_bucket_retention_days        = 30
  force_destroy                        = true
  storage_object_viewer_principal      = "user:someone@example.com"
  storage_object_admin_principal       = "user:someone@example.com"
}

run "check_module_outputs" {
  command = plan
  assert {
    condition     = output.state_bucket_name == "my-state-bucket"
    error_message = "Expected state bucket name to be 'my-state-bucket', got '${output.state_bucket_name}'"
  }

  assert {
    condition     = output.logging_bucket_name == "my-logging-bucket"
    error_message = "Expected logging bucket name to be 'my-logging-bucket', got '${output.logging_bucket_name}'"
  }
}
