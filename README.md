
# terraform-gcs-remote-state-bootstrap

## About

This module provisions:

- A Google Cloud Storage bucket for remote Terraform state
- A separate logging bucket for audit/access logs
- Encryption of the state bucket using a Customer-Managed Encryption Key (CMEK) via Google Cloud KMS

**Important:** You must have an existing KMS key (crypto key) set up in your project and provide its full resource ID to this module. The module does not create the KMS key for you. See the `kms_key_resource_name` input for the required format.

---

## Prerequisites

Before using this module, you must:

- Create a KMS key ring and crypto key in your GCP project. Note the full resource name of the crypto key (e.g., `projects/[PROJECT_ID]/locations/[REGION]/keyRings/[KEY_RING_NAME]/cryptoKeys/[KEY_NAME]`).
- Activate the following APIs in your GCP project:
  - Cloud Storage API (`storage.googleapis.com`)
  - IAM API (`iam.googleapis.com`)

**Recommended:** Enable these APIs via Terraform:

```hcl
resource "google_project_service" "required_services" {
  for_each = toset([
    "storage.googleapis.com",
    "iam.googleapis.com"
  ])
  project = var.project_id
  service = each.key
  disable_on_destroy = false
}
```

# Example: Creating a KMS key (if you do not already have one)

```hcl
resource "google_kms_key_ring" "state" {
  name     = "your-key-ring"
  location = "europe-west2"
  project  = var.project_id
}

resource "google_kms_crypto_key" "state" {
  name            = "your-crypto-key"
  key_ring        = google_kms_key_ring.state.id
  rotation_period = "100000s"
}
```

---

## Usage Example

Minimal setup with placeholder values:

```hcl
module "remote_state_bootstrap" {
  source  = "github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap"
  version = "{VERSION}"

  project_id                      = "[YOUR_PROJECT_ID]"
  storage_object_viewer_principal = "user:someone@example.com"
  storage_object_admin_principal  = "user:someone@example.com"
  kms_key_resource_name           = "projects/PROJECT_ID/locations/REGION/keyRings/KEY_RING_NAME/cryptoKeys/KEY_NAME"
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
| [google_kms_crypto_key_iam_member.storage_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
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
| <a name="input_kms_key_resource_name"></a> [kms\_key\_resource\_name](#input\_kms\_key\_resource\_name) | The full resource name of the KMS key to use for bucket encryption, e.g. projects/[PROJECT\_ID]/locations/[REGION]/keyRings/[KEY\_RING\_NAME]/cryptoKeys/[KEY\_NAME]. | `string` | n/a | yes |
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
| <a name="output_logging_bucket_name"></a> [logging\_bucket\_name](#output\_logging\_bucket\_name) | The name of the logging bucket. |
| <a name="output_state_bucket_name"></a> [state\_bucket\_name](#output\_state\_bucket\_name) | The name of the remote state bucket. |
<!-- END_TF_DOCS -->
