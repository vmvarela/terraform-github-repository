# GitHub Repository Terraform module

A Terraform module for comprehensive GitHub repository management. This module offers complete lifecycle control for repositories, including permissions, GitHub Actions configuration, deploy keys, repository properties, user and team access management, autolink references, advanced security features, and ruleset configurations.

The module enables infrastructure-as-code practices for GitHub repositories, supporting key features such as:
-	Repository creation with customizable settings (visibility, branch protection, merge strategies)
-	Team and user permission management with granular access control
-	GitHub Actions integration with secrets and variables management
-	Deploy keys configuration for automated deployments
-	Autolink references for connecting external resources
-	Advanced security features configuration
-	Custom ruleset implementation for repository governance
-	Branch protection policies with required checks

## Usage

```hcl
module "repo" {
  source = "github.com/vmvarela/terraform-github-repository"

  name           = "my-repo"
  visibility     = "private"
  default_branch = "main"
  template       = "MarketingPipeline/Awesome-Repo-Template"
}
```

## Examples

- [simple](https://github.com/vmvarela/terraform-github-repository/tree/master/examples/simple) - Single repository from a template
- [complete](https://github.com/vmvarela/terraform-github-repository/tree/master/examples/complete) - Several repositories (with configuration from a .yaml)


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.6.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.5.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.3 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | >= 6.6.0 |
| <a name="provider_local"></a> [local](#provider\_local) | >= 2.5.2 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.2.3 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.0.6 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_environment"></a> [environment](#module\_environment) | ./modules/environment | n/a |
| <a name="module_file"></a> [file](#module\_file) | ./modules/file | n/a |
| <a name="module_ruleset"></a> [ruleset](#module\_ruleset) | ./modules/ruleset | n/a |
| <a name="module_webhook"></a> [webhook](#module\_webhook) | ./modules/webhook | n/a |

## Resources

| Name | Type |
|------|------|
| [github_actions_repository_access_level.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_repository_access_level) | resource |
| [github_actions_repository_permissions.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_repository_permissions) | resource |
| [github_actions_secret.encrypted](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_secret.plaintext](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_variable.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) | resource |
| [github_branch.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch_default.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_dependabot_secret.encrypted](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/dependabot_secret) | resource |
| [github_dependabot_secret.plaintext](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/dependabot_secret) | resource |
| [github_issue_labels.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_labels) | resource |
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_autolink_reference.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_autolink_reference) | resource |
| [github_repository_collaborators.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborators) | resource |
| [github_repository_custom_property.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_custom_property) | resource |
| [github_repository_dependabot_security_updates.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_dependabot_security_updates) | resource |
| [github_repository_deploy_key.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |
| [local_file.private_key_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.create_subfolder](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions_access_level"></a> [actions\_access\_level](#input\_actions\_access\_level) | (Optional) The access level for the repository. Must be one of `none`, `user`, `organization`, or `enterprise`. Default: `none` | `string` | `null` | no |
| <a name="input_actions_allowed_github"></a> [actions\_allowed\_github](#input\_actions\_allowed\_github) | (Optional) Whether GitHub-owned actions are allowed in the repository. Only available when `actions_allowed_policy` = `selected`. | `bool` | `true` | no |
| <a name="input_actions_allowed_patterns"></a> [actions\_allowed\_patterns](#input\_actions\_allowed\_patterns) | (Optional) Specifies a list of string-matching patterns to allow specific action(s). Wildcards, tags, and SHAs are allowed. For example, `monalisa/octocat@`, `monalisa/octocat@v2`, `monalisa/`. | `set(string)` | `[]` | no |
| <a name="input_actions_allowed_policy"></a> [actions\_allowed\_policy](#input\_actions\_allowed\_policy) | (Optional) The permissions policy that controls the actions that are allowed to run. Can be one of: `all`, `local_only`, or `selected`. | `string` | `null` | no |
| <a name="input_actions_allowed_verified"></a> [actions\_allowed\_verified](#input\_actions\_allowed\_verified) | (Optional) Whether actions in GitHub Marketplace from verified creators are allowed. Set to `true` to allow all GitHub Marketplace actions by verified creators. Only available when `actions_allowed_policy` = `selected`. | `bool` | `null` | no |
| <a name="input_alias"></a> [alias](#input\_alias) | (Optional) The original name of the repository (useful for renaming) | `string` | `null` | no |
| <a name="input_allow_auto_merge"></a> [allow\_auto\_merge](#input\_allow\_auto\_merge) | (Optional) Set to `true` to allow auto-merging pull requests on the repository. | `bool` | `null` | no |
| <a name="input_allow_merge_commit"></a> [allow\_merge\_commit](#input\_allow\_merge\_commit) | (Optional) Either `true` to allow merging pull requests with a merge commit, or `false` to prevent merging pull requests with merge commits. | `bool` | `null` | no |
| <a name="input_allow_rebase_merge"></a> [allow\_rebase\_merge](#input\_allow\_rebase\_merge) | (Optional) Either `true` to allow rebase-merging pull requests, or `false` to prevent rebase-merging. | `bool` | `null` | no |
| <a name="input_allow_squash_merge"></a> [allow\_squash\_merge](#input\_allow\_squash\_merge) | (Optional) Either `true` to allow squash-merging pull requests, or `false` to prevent squash-merging. | `bool` | `null` | no |
| <a name="input_allow_update_branch"></a> [allow\_update\_branch](#input\_allow\_update\_branch) | (Optional) Either `true` to always allow a pull request head branch that is behind its base branch to be updated even if it is not required to be up to date before merging, or `false` otherwise. | `bool` | `null` | no |
| <a name="input_archive_on_destroy"></a> [archive\_on\_destroy](#input\_archive\_on\_destroy) | (Optional) Set to `true` to archive the repository instead of deleting on destroy. | `bool` | `null` | no |
| <a name="input_archived"></a> [archived](#input\_archived) | (Optional) Whether to archive this repository. `false` will unarchive a previously archived repository. | `bool` | `null` | no |
| <a name="input_auto_init"></a> [auto\_init](#input\_auto\_init) | (Optional) Set to `true` to produce an initial commit in the repository | `bool` | `null` | no |
| <a name="input_autolink_references"></a> [autolink\_references](#input\_autolink\_references) | (Optional) The list of autolink references of the repository (key: key\_prefix) | <pre>map(object({<br/>    target_url_template = string<br/>    is_alphanumeric     = optional(bool)<br/>  }))</pre> | `{}` | no |
| <a name="input_branches"></a> [branches](#input\_branches) | (Optional) The list of branches to create (map of name and source branch) | `map(string)` | `{}` | no |
| <a name="input_custom_properties"></a> [custom\_properties](#input\_custom\_properties) | (Optional) The custom properties for the new repository. The keys are the custom property names, and the values are the corresponding custom property values. | `any` | `{}` | no |
| <a name="input_custom_properties_types"></a> [custom\_properties\_types](#input\_custom\_properties\_types) | (Optional) The list of types associated to properties (key: property\_name) | `map(string)` | `{}` | no |
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | (Optional) Updates the default branch for this repository. | `string` | `null` | no |
| <a name="input_delete_branch_on_merge"></a> [delete\_branch\_on\_merge](#input\_delete\_branch\_on\_merge) | (Optional) Either `true` to enable automatic deletion of branches on merge, or `false` to disable. | `bool` | `null` | no |
| <a name="input_dependabot_copy_secrets"></a> [dependabot\_copy\_secrets](#input\_dependabot\_copy\_secrets) | (Optional) If dependabot uses same repository secrets (plaintext or encrypted). Makes a copy. | `bool` | `false` | no |
| <a name="input_dependabot_secrets"></a> [dependabot\_secrets](#input\_dependabot\_secrets) | (Optional) The list of secrets configuration of the repository (key: `secret_name`). Only plaintext secrets. | `map(string)` | `{}` | no |
| <a name="input_dependabot_secrets_encrypted"></a> [dependabot\_secrets\_encrypted](#input\_dependabot\_secrets\_encrypted) | (Optional) The list of secrets configuration of the repository (key: `secret_name`). Only encrypted secrets. | `map(string)` | `{}` | no |
| <a name="input_deploy_keys"></a> [deploy\_keys](#input\_deploy\_keys) | (Optional) The list of deploy keys of the repository (key: key\_title) | <pre>map(object({<br/>    key       = optional(string) # auto-generated if not provided<br/>    read_only = optional(bool, true)<br/>  }))</pre> | `{}` | no |
| <a name="input_deploy_keys_path"></a> [deploy\_keys\_path](#input\_deploy\_keys\_path) | (Optional) The path to the generated deploy keys for this repository | `string` | `"./deploy_keys"` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A short description of the repository that will show up on GitHub | `string` | `null` | no |
| <a name="input_enable_actions"></a> [enable\_actions](#input\_enable\_actions) | (Optional) Either `true` to enable Github Actions, or `false` to disable. | `bool` | `null` | no |
| <a name="input_enable_advanced_security"></a> [enable\_advanced\_security](#input\_enable\_advanced\_security) | (Optional) Use to enable or disable GitHub Advanced Security for this repository. | `bool` | `null` | no |
| <a name="input_enable_dependabot_security_updates"></a> [enable\_dependabot\_security\_updates](#input\_enable\_dependabot\_security\_updates) | (Optional) Set to `true` to enable the automated security fixes. | `bool` | `null` | no |
| <a name="input_enable_secret_scanning"></a> [enable\_secret\_scanning](#input\_enable\_secret\_scanning) | (Optional) Use to enable or disable secret scanning for this repository. If set to `true`, the repository's visibility must be `public` or `enable_advanced_security` must also be `true`. | `bool` | `null` | no |
| <a name="input_enable_secret_scanning_push_protection"></a> [enable\_secret\_scanning\_push\_protection](#input\_enable\_secret\_scanning\_push\_protection) | (Optional) Use to enable or disable secret scanning push protection for this repository. If set to `true`, the repository's visibility must be `public` or `enable_advanced_security` must also be `true`. | `bool` | `null` | no |
| <a name="input_enable_vulnerability_alerts"></a> [enable\_vulnerability\_alerts](#input\_enable\_vulnerability\_alerts) | (Optional) Either `true` to enable vulnerability alerts, or `false` to disable vulnerability alerts. | `bool` | `null` | no |
| <a name="input_environments"></a> [environments](#input\_environments) | (Optional) The list of environments configuration of the repository (key: environment\_name). See [environment module](./modules/environment/README.md) for arguments. | `any` | `{}` | no |
| <a name="input_files"></a> [files](#input\_files) | (Optional) The list of files of the repository (key: file\_path). See [file module](./modules/file/README.md) for arguments. | `any` | `{}` | no |
| <a name="input_gitignore_template"></a> [gitignore\_template](#input\_gitignore\_template) | (Optional) Use the [name of the template](https://github.com/github/gitignore) without the extension. For example, `Haskell`. | `string` | `null` | no |
| <a name="input_has_downloads"></a> [has\_downloads](#input\_has\_downloads) | (Optional) Whether downloads are enabled. | `bool` | `null` | no |
| <a name="input_has_issues"></a> [has\_issues](#input\_has\_issues) | (Optional) Either `true` to enable issues for this repository or `false` to disable them. | `bool` | `null` | no |
| <a name="input_has_projects"></a> [has\_projects](#input\_has\_projects) | (Optional) Either `true` to enable projects for this repository or `false` to disable them. **Note:** If you're creating a repository in an organization that has disabled repository projects, the default is `false`, and if you pass `true`, the API returns an error. | `bool` | `null` | no |
| <a name="input_has_wiki"></a> [has\_wiki](#input\_has\_wiki) | (Optional) Either `true` to enable the wiki for this repository, `false` to disable it. | `bool` | `null` | no |
| <a name="input_homepage"></a> [homepage](#input\_homepage) | (Optional) A URL with more information about the repository | `string` | `null` | no |
| <a name="input_is_template"></a> [is\_template](#input\_is\_template) | (Optional) Either `true` to make this repo available as a template repository or `false` to prevent it. | `bool` | `null` | no |
| <a name="input_issue_labels"></a> [issue\_labels](#input\_issue\_labels) | (Optional) The list of issue labels of the repository (key: `label_name`, argument: `description`) | `map(string)` | `{}` | no |
| <a name="input_issue_labels_colors"></a> [issue\_labels\_colors](#input\_issue\_labels\_colors) | (Optional) The list of issue labels and associated color (key: `label_name`, arguments `color`) | `map(string)` | `{}` | no |
| <a name="input_license_template"></a> [license\_template](#input\_license\_template) | (Optional) Use the [name of the template](https://github.com/github/choosealicense.com/tree/gh-pages/_licenses) without the extension. For example, `mit` or `mpl-2.0`. | `string` | `null` | no |
| <a name="input_merge_commit_message"></a> [merge\_commit\_message](#input\_merge\_commit\_message) | (Optional) Can be `PR_BODY`, `PR_TITLE`, or `BLANK` for a default merge commit message. Applicable only if `allow_merge_commit` is `true`. | `string` | `null` | no |
| <a name="input_merge_commit_title"></a> [merge\_commit\_title](#input\_merge\_commit\_title) | (Optional) Can be `PR_TITLE` or `MERGE_MESSAGE` for a default merge commit title. Applicable only if `allow_merge_commit` is `true`. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the repository. Changing this will rename the repository | `string` | n/a | yes |
| <a name="input_pages_build_type"></a> [pages\_build\_type](#input\_pages\_build\_type) | (Optional) The type of GitHub Pages site to build. Can be `legacy` or `workflow`. If you use `legacy` as build type you need to set the option `pages_source_branch`. | `string` | `null` | no |
| <a name="input_pages_cname"></a> [pages\_cname](#input\_pages\_cname) | (Optional) The custom domain for the repository. This can only be set after the repository has been created. | `string` | `null` | no |
| <a name="input_pages_source_branch"></a> [pages\_source\_branch](#input\_pages\_source\_branch) | (Optional) The repository branch used to publish the site's source files. (i.e. `main` or `gh-pages`) | `string` | `null` | no |
| <a name="input_pages_source_path"></a> [pages\_source\_path](#input\_pages\_source\_path) | (Optional) The repository directory from which the site publishes (Default: `/`). | `string` | `null` | no |
| <a name="input_private"></a> [private](#input\_private) | (Optional) Either true to make the repository private or false to make it public. Default: false. **Note:** You will get a 422 error if the organization restricts changing repository visibility to organization owners and a non-owner tries to change the value of private. | `bool` | `null` | no |
| <a name="input_rulesets"></a> [rulesets](#input\_rulesets) | (Optional) Repository rules (key: rule\_name). See [environment module](./modules/ruleset/README.md) for arguments. | `any` | `{}` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | (Optional) The list of secrets configuration of the repository (key: secret\_name). Only plaintext secrets. | `map(string)` | `{}` | no |
| <a name="input_secrets_encrypted"></a> [secrets\_encrypted](#input\_secrets\_encrypted) | (Optional) The list of secrets configuration of the repository (key: secret\_name). Only encrypted secrets. | `map(string)` | `{}` | no |
| <a name="input_squash_merge_commit_message"></a> [squash\_merge\_commit\_message](#input\_squash\_merge\_commit\_message) | (Optional) Can be `PR_BODY`, `COMMIT_MESSAGES`, or `BLANK` for a default squash merge commit message. Applicable only if `allow_squash_merge` is `true`. | `string` | `null` | no |
| <a name="input_squash_merge_commit_title"></a> [squash\_merge\_commit\_title](#input\_squash\_merge\_commit\_title) | (Optional) Can be `PR_TITLE` or `COMMIT_OR_PR_TITLE` for a default squash merge commit title. Applicable only if `allow_squash_merge` is `true`. | `string` | `null` | no |
| <a name="input_teams"></a> [teams](#input\_teams) | (Optional) The list of collaborators (teams) of the repository | `map(string)` | `{}` | no |
| <a name="input_template"></a> [template](#input\_template) | (Optional) Use a template repository to create this resource (owner/repo) | `string` | `null` | no |
| <a name="input_template_include_all_branches"></a> [template\_include\_all\_branches](#input\_template\_include\_all\_branches) | (Optional) Whether the new repository should include all the branches from the template repository (defaults to false, which includes only the default branch from the template). | `bool` | `null` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | (Optional) A list of topics to set on the repository | `set(string)` | `[]` | no |
| <a name="input_users"></a> [users](#input\_users) | (Optional) The list of collaborators (users) of the repository | `map(string)` | `{}` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | (Optional) The list of variables configuration of the repository (key: variable\_name) | `map(string)` | `{}` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | (Optional) Can be `public` or `private` (or `internal` if your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+). The visibility parameter overrides the `private` parameter. | `string` | `null` | no |
| <a name="input_web_commit_signoff_required"></a> [web\_commit\_signoff\_required](#input\_web\_commit\_signoff\_required) | (Optional) Require contributors to sign off on web-based commits. See more here. Defaults to `false` | `bool` | `null` | no |
| <a name="input_webhooks"></a> [webhooks](#input\_webhooks) | (Optional) The list of webhooks of the repository. See [webhook module](./modules/webhook/README.md) for arguments. | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alias"></a> [alias](#output\_alias) | Alias (used for renaming) |
| <a name="output_repository"></a> [repository](#output\_repository) | Created repository |
<!-- END_TF_DOCS -->

## Authors

Module is maintained by [Victor M. Varela](https://github.com/vmvarela).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/vmvarela/terraform-github-repository/tree/master/LICENSE) for full details.
