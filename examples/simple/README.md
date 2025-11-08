# Simple Repository Example

This example demonstrates how to create a basic GitHub repository with minimal configuration using this Terraform module.

## Features

- Basic repository with public visibility
- Issue tracking and wiki enabled
- Repository topics for better discoverability
- Simple branch protection on the main branch

## Usage

To run this example you need to set the `GITHUB_TOKEN` environment variable and execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.2 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_repo"></a> [repo](#module\_repo) | ../.. | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
