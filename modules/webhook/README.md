# GitHub Webhook Terraform sub-module

A Terraform module for GitHub webhooks GitHub.cks

## Usage

```hcl
module "webhook" {
  source         = "github.com/vmvarela/terraform-github-repository//modules/webhook"
  repository     = "my-repo"
  url            = "https://webhooks.my-company.com"
  content_type   = "json"
  default_branch = "main"
  events         = ["issues"]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | >= 6.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository_webhook.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_webhook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_content_type"></a> [content\_type](#input\_content\_type) | (Required) The content type for the payload. Valid values are either `form` or `json`. | `string` | n/a | yes |
| <a name="input_events"></a> [events](#input\_events) | (Required) A list of events which should trigger the webhook. See a list of [available events](https://docs.github.com/es/webhooks/webhook-events-and-payloads). | `set(string)` | n/a | yes |
| <a name="input_insecure_ssl"></a> [insecure\_ssl](#input\_insecure\_ssl) | (Optional) Insecure SSL boolean toggle. | `bool` | `false` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | (Required) The repository of the webhook. | `string` | n/a | yes |
| <a name="input_secret"></a> [secret](#input\_secret) | (Optional) The shared secret for the webhook | `string` | `null` | no |
| <a name="input_url"></a> [url](#input\_url) | (Required) The URL of the webhook. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_webhook"></a> [webhook](#output\_webhook) | Created webhook |
<!-- END_TF_DOCS -->

## Authors

Module is maintained by [Victor M. Varela](https://github.com/vmvarela).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/vmvarela/terraform-github-repository/tree/master/LICENSE) for full details.
