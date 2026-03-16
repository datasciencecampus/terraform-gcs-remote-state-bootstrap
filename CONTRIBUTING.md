# Contributing to terraform-gcs-remote-state-bootstrap

Thank you for your interest in contributing!

---

## Developer Workflow

### 1. Setup

- Fork the repository and clone your fork locally.
- Create a new branch for your changes.
- Install [pre-commit](https://pre-commit.com/) and set up hooks:

  ```sh
  pre-commit install
  pre-commit run --all-files
  ```

  This ensures your code meets style and quality standards before submission.

### 2. Make Changes

- Follow existing code style and conventions.
- Use [Conventional Commits](https://www.conventionalcommits.org/) for commit messages (e.g., `feat:`, `fix:`, `docs:`).
- Add or update tests for new features or bug fixes.
- Document any new variables or outputs in the README.

### 3. Run Tests

This project uses [terraform test](https://developer.hashicorp.com/terraform/tutorials/terraform-test/terraform-test-overview) for module testing.

**Prerequisites:**

- Terraform >= 1.6.0
- Access to a Google Cloud project for live testing

**How to Run Tests:**

You must provide a valid GCP project ID for testing. You can use any live test project you have access to. The project ID is passed as a variable to the test command:

```sh
terraform test -var 'project_id=YOUR_TEST_PROJECT_ID'
```

Replace `YOUR_TEST_PROJECT_ID` with your actual GCP project ID.

> **Note:**
>
> - Tests will create and destroy resources in the specified project. Use a sandbox or test project to avoid impacting production resources.

### 4. Prepare for Release

- Ensure all user-facing changes are documented in the CHANGELOG.md.
- Update the version as appropriate.
- Use conventional commit messages to help automate changelog generation and versioning.

### 5. Submit Your Changes

- Push your branch to your fork.
- Open a pull request against the `main` branch.
- Provide a clear description of your changes.

---

## Contribution Policy

Currently, only ONS colleagues are accepted as contributors. However, anyone is welcome to raise an issue for questions, suggestions, or support.

## Contact

For questions or support, open an issue in the repository.
