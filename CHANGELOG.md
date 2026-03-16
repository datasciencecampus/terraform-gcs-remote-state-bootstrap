# Changelog

## [1.1.1](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/compare/v1.1.0...v1.1.1) (2026-03-16)


### Bug Fixes

* add depends_on for IAM members to ensure resource dependencies are respected ([6d839de](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/commit/6d839deaebb861c6162ce16d342b96e9d9b5e6ca))

## [1.1.0](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/compare/v1.0.1...v1.1.0) (2026-03-16)


### Features

* add KMS access for Cloud Storage service account ([3b91f90](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/commit/3b91f90e1a43238626454e5c873dee606f0b33dd))

## [1.0.1](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/compare/v1.0.0...v1.0.1) (2026-03-16)


### Bug Fixes

* update module label to match repository name ([9b55a4d](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/commit/9b55a4dea9d031f8ba3fc10ec092e4589da3a316))

## [1.0.0](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/compare/v0.4.0...v1.0.0) (2026-03-16)


### ⚠ BREAKING CHANGES

* This breaks the functionality of previous versions as this no longer provisions the KMS within the module.

### Code Refactoring

* update KMS key management by removing hardcoded variables and introducing a resource name variable ([6d3e896](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/commit/6d3e896b3f16ab21529214919d7cbf0d19c95c84))

## [0.4.0](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/compare/v0.3.3...v0.4.0) (2026-03-16)


### Features

* implement dynamic naming conventions for state and logging buckets ([ba3938b](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/commit/ba3938bcc21cddc406ac2071b7f645a0f0829abc))

## [0.3.3](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/compare/v0.3.2...v0.3.3) (2026-03-16)


### Bug Fixes

* remove pull_request trigger and update version placeholder in README ([9895bb2](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/commit/9895bb22dda615e25b5fe0243e1a9eef727a2e88))

## [0.3.2](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/compare/v0.3.1...v0.3.2) (2026-03-16)


### Bug Fixes

* update kms_location to match the specified region ([d24bfd7](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/commit/d24bfd73f520ee60e8803b15b1b77303afe7cd1d))

## [0.3.1](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/compare/v0.3.0...v0.3.1) (2026-03-16)


### Bug Fixes

* update project_id formatting in README.md ([b6e5c9c](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/commit/b6e5c9ceaea166e0bf8e41beabb3ac942015c2c5))

## [0.3.0](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/compare/v0.2.1...v0.3.0) (2026-03-16)


### Features

* update module source and version in README.md ([6a50af7](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/commit/6a50af7162f2b0093408f1c31337fcfbee61402c))

## [0.2.1](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/compare/v0.2.0...v0.2.1) (2026-03-16)


### Bug Fixes

* correct CODEOWNERS syntax by adding missing '@' symbol ([0a66a41](https://github.com/datasciencecampus/terraform-gcs-remote-state-bootstrap/commit/0a66a4143948431dc88e503eb6cd3f265451a7fa))

## [0.2.0](https://github.com/datasciencecampus/rst/compare/v0.1.0...v0.2.0) (2026-03-16)


### Features

* Add labels to storage buckets and define labels variable ([5f1ca46](https://github.com/datasciencecampus/rst/commit/5f1ca466a698258096c1b0eed9a8f797f3ec35e5))
* Merge labels into local variable for storage buckets ([d107ef5](https://github.com/datasciencecampus/rst/commit/d107ef533b84319e11204f54ba05524f5198d316))

## 0.1.0 (2026-03-16)


### Features

* Add Dependabot configuration for GitHub Actions and Terraform updates ([de101e9](https://github.com/datasciencecampus/rst/commit/de101e990a35832e035c4d6600ee86c7e28fc3ab))
* Add initial Terraform module for remote state bucket with CMEK and logging ([aba1d65](https://github.com/datasciencecampus/rst/commit/aba1d656a45329a8256fc5bb90f0bc54e3905713))
* Add release workflow for Terraform module using release-please ([6f20985](https://github.com/datasciencecampus/rst/commit/6f209857b62d8db474724988ca38c80e33983f7f))


### Bug Fixes

* Correct module name in README and update variable defaults in tests and variables files ([1b2cf5b](https://github.com/datasciencecampus/rst/commit/1b2cf5bfd6e351c3525cdb05c88e12969d265575))
* Refactor terraform validate command to improve readability ([575318e](https://github.com/datasciencecampus/rst/commit/575318ee86bcb0b16cf547fe48489beaeb4e24ab))
* Remove redundant terraform test step from CI workflow ([5334be8](https://github.com/datasciencecampus/rst/commit/5334be8d6f94d08d74689e01a8f2c010553bddce))
* Remove unnecessary blank lines from CI workflow ([50c3833](https://github.com/datasciencecampus/rst/commit/50c38336e06cbf6e922ca4f8f871b37b4422c67a))
* Remove unused test_apply_module block from main_test.tftest.hcl ([c4c7138](https://github.com/datasciencecampus/rst/commit/c4c71388f1540e7000a56173702c287d54eae047))
* Simplify terraform validate command to run on the current directory ([efbaec0](https://github.com/datasciencecampus/rst/commit/efbaec0039eb427707cf225297bf8ddedc1bc787))
* Update module name in README to new repo name ([d703697](https://github.com/datasciencecampus/rst/commit/d7036979d35db514dd8b3dfe4f4a8719316df4da))
* Update terraform validate command for improved directory handling ([678e927](https://github.com/datasciencecampus/rst/commit/678e927512dccfdb367c7cff2c6b0e276b0dfd0c))
* Update terraform validate command to exclude tests directory ([fbddfdf](https://github.com/datasciencecampus/rst/commit/fbddfdfd05894bc920ac0dbaa772c7b9a8b8244b))
* Update terraform validate command to include specific file types ([6374362](https://github.com/datasciencecampus/rst/commit/63743623fca4b9c092de54194c45a6b7f3354780))
* Update terraform validate command to run on the current directory ([9fc193b](https://github.com/datasciencecampus/rst/commit/9fc193bf0f4cd9b9112176f39b96c31d3076fecc))
* Update terraform validate command to specify test directory ([6744c4d](https://github.com/datasciencecampus/rst/commit/6744c4d3807b160ed755ed6df3f52a81bb0cd785))
