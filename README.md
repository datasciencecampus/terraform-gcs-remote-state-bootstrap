
# terraform-gcs-remote-state-bootstrap

## About

This module provisions:

- A Google Cloud Storage bucket for remote Terraform state
- A Customer-Managed Encryption Key (CMEK) using Google Cloud KMS (key ring and crypto key)
- A separate logging bucket for audit/access logs

---

## Required Google Cloud Services

Before using this module, you must activate the following APIs in your GCP project:

- Cloud Storage API (`storage.googleapis.com`)
- Cloud KMS API (`cloudkms.googleapis.com`)
- IAM API (`iam.googleapis.com`)

**Recommended:** Enable these APIs via Terraform:

```hcl
resource "google_project_service" "required_services" {
  for_each = toset([
    "storage.googleapis.com",
    "cloudkms.googleapis.com",
    "iam.googleapis.com"
  ])
  project = var.project_id
  service = each.key
  disable_on_destroy = false
}
```

---

## Usage Example

Minimal setup with placeholder values:

```hcl
module "remote_state_bootstrap" {
  source  = "github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap"
  version = "{VERSION}"

  project_id                      = "your-gcp-project-id"
  storage_object_viewer_principal = "user:someone@example.com"
  storage_object_admin_principal  = "user:someone@example.com"
  # ...add any other required or optional variables
}
```

> **Note:**
>
> - Replace all placeholder values with your actual GCP project and resource names.
> - You must authenticate with Google Cloud and have the necessary permissions to create resources.
> - Do not commit real credentials or sensitive data to your repository.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 7.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_kms_crypto_key.state](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_key_ring.state](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_storage_bucket.logging](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket.state](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.logging_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_iam_member.logging_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_iam_member.state_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_iam_member.state_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_location"></a> [bucket\_location](#input\_bucket\_location) | Location for the buckets. | `string` | `"europe-west2"` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Whether to force destroy the buckets (deleting all objects). Use with caution. | `bool` | `false` | no |
| <a name="input_kms_crypto_key_name_override"></a> [kms\_crypto\_key\_name\_override](#input\_kms\_crypto\_key\_name\_override) | Name of the KMS crypto key. | `string` | `""` | no |
| <a name="input_kms_key_ring_name_override"></a> [kms\_key\_ring\_name\_override](#input\_kms\_key\_ring\_name\_override) | Name of the KMS key ring. | `string` | `""` | no |
| <a name="input_kms_location"></a> [kms\_location](#input\_kms\_location) | Location for the KMS key ring. | `string` | `"europe-west2"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to apply to the buckets. | `map(string)` | `{}` | no |
| <a name="input_logging_bucket_name_override"></a> [logging\_bucket\_name\_override](#input\_logging\_bucket\_name\_override) | Name of the logging bucket. | `string` | `""` | no |
| <a name="input_logging_bucket_retention_days"></a> [logging\_bucket\_retention\_days](#input\_logging\_bucket\_retention\_days) | Number of days to retain objects in the logging bucket before automatic deletion. | `number` | `30` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project ID. | `string` | n/a | yes |
| <a name="input_state_bucket_name_override"></a> [state\_bucket\_name\_override](#input\_state\_bucket\_name\_override) | Name of the remote state bucket. | `string` | `""` | no |
| <a name="input_state_bucket_version_retention_count"></a> [state\_bucket\_version\_retention\_count](#input\_state\_bucket\_version\_retention\_count) | Number of newer versions to retain in the state bucket before older versions are automatically deleted. | `number` | `5` | no |
| <a name="input_storage_object_admin_principal"></a> [storage\_object\_admin\_principal](#input\_storage\_object\_admin\_principal) | The principal to be granted the Storage Object Admin role on the state bucket. Must be a valid IAM principal string, e.g.:<br/>  - user:someone@example.com<br/>  - group:admins@example.com<br/>  - serviceAccount:my-sa@project.iam.gserviceaccount.com<br/>  - domain:example.com | `string` | n/a | yes |
| <a name="input_storage_object_viewer_principal"></a> [storage\_object\_viewer\_principal](#input\_storage\_object\_viewer\_principal) | The principal to be granted the Storage Object Viewer role on the state bucket. Must be a valid IAM principal string, e.g.:<br/>  - user:someone@example.com<br/>  - group:admins@example.com<br/>  - serviceAccount:my-sa@project.iam.gserviceaccount.com<br/>  - domain:example.com | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_crypto_key_id"></a> [kms\_crypto\_key\_id](#output\_kms\_crypto\_key\_id) | The ID of the KMS crypto key. |
| <a name="output_kms_key_ring_id"></a> [kms\_key\_ring\_id](#output\_kms\_key\_ring\_id) | The ID of the KMS key ring. |
| <a name="output_logging_bucket_name"></a> [logging\_bucket\_name](#output\_logging\_bucket\_name) | The name of the logging bucket. |
| <a name="output_state_bucket_name"></a> [state\_bucket\_name](#output\_state\_bucket\_name) | The name of the remote state bucket. |
<!-- END_TF_DOCS -->
