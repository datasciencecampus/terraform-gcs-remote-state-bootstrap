test {
  parallel = true
}

variables {
  force_destroy                   = true
  storage_object_viewer_principal = "user:someone@example.com"
  storage_object_admin_principal  = "user:someone@example.com"
}

run "test-apply" {
  command = plan
}
