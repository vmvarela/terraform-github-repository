# GitHub Repository Terraform module

Terraform module which creates repositories on GitHub.

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

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_environment_secret.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_secret) | resource |
| [github_actions_environment_variable.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_variable) | resource |
| [github_actions_repository_access_level.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_repository_access_level) | resource |
| [github_actions_repository_permissions.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_repository_permissions) | resource |
| [github_actions_secret.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_variable.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) | resource |
| [github_branch.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch_default.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_dependabot_secret.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/dependabot_secret) | resource |
| [github_issue_labels.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_labels) | resource |
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_autolink_reference.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_autolink_reference) | resource |
| [github_repository_collaborators.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborators) | resource |
| [github_repository_custom_property.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_custom_property) | resource |
| [github_repository_dependabot_security_updates.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_dependabot_security_updates) | resource |
| [github_repository_deploy_key.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |
| [github_repository_environment.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment) | resource |
| [github_repository_environment_deployment_policy.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment_deployment_policy) | resource |
| [github_repository_file.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_ruleset.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_ruleset) | resource |
| [github_repository_webhook.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_webhook) | resource |
| [local_file.private_key_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.create_subfolder](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions_access_level"></a> [actions\_access\_level](#input\_actions\_access\_level) | (Optional) The access level for the repository. Must be one of `none`, `user`, `organization`, or `enterprise`. Default: `none` | `string` | `null` | no |
| <a name="input_actions_permissions"></a> [actions\_permissions](#input\_actions\_permissions) | (Optional) The list of Github Actions permissions configuration of the repository: `allowed_actions` - (Optional) The permissions policy that controls the actions that are allowed to run. Can be one of: `all`, `local_only`, or `selected`.; `enabled` - (Optional) Should GitHub actions be enabled on this repository?; `github_owned_allowed` - (Optional) Whether GitHub-owned actions are allowed in the repository.; `patterns_allowed` - (Optional) Specifies a list of string-matching patterns to allow specific action(s). Wildcards, tags, and SHAs are allowed. For example, monalisa/octocat@, monalisa/octocat@v2, monalisa/.; `verified_allowed` -  (Optional) Whether actions in GitHub Marketplace from verified creators are allowed. Set to true to allow all GitHub Marketplace actions by verified creators. | <pre>object({<br/>    enabled              = optional(bool)<br/>    allowed_actions      = optional(string)<br/>    github_owned_allowed = optional(bool)<br/>    patterns_allowed     = optional(list(string))<br/>    verified_allowed     = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_advanced_security"></a> [advanced\_security](#input\_advanced\_security) | (Optional) Set to `true` to enable advanced security features on the repository. | `bool` | `null` | no |
| <a name="input_alias"></a> [alias](#input\_alias) | (Optional) The original name of the repository (useful for renaming) | `string` | `null` | no |
| <a name="input_allow_auto_merge"></a> [allow\_auto\_merge](#input\_allow\_auto\_merge) | (Optional) Set to `true` to allow auto-merging pull requests on the repository. | `bool` | `null` | no |
| <a name="input_allow_merge_commit"></a> [allow\_merge\_commit](#input\_allow\_merge\_commit) | (Optional) Set to `false` to disable merge commits on the repository. | `bool` | `null` | no |
| <a name="input_allow_rebase_merge"></a> [allow\_rebase\_merge](#input\_allow\_rebase\_merge) | (Optional) Set to `false` to disable rebase merges on the repository. | `bool` | `null` | no |
| <a name="input_allow_squash_merge"></a> [allow\_squash\_merge](#input\_allow\_squash\_merge) | (Optional) Set to `false` to disable squash merges on the repository. | `bool` | `null` | no |
| <a name="input_allow_update_branch"></a> [allow\_update\_branch](#input\_allow\_update\_branch) | (Optional) - Set to `true` to always suggest updating pull request branches. | `bool` | `null` | no |
| <a name="input_archive_on_destroy"></a> [archive\_on\_destroy](#input\_archive\_on\_destroy) | (Optional) Set to `true` to archive the repository instead of deleting on destroy. | `bool` | `null` | no |
| <a name="input_archived"></a> [archived](#input\_archived) | (Optional) Specifies if the repository should be archived. Defaults to `false`. **NOTE:** Currently, the API does not support unarchiving. | `bool` | `null` | no |
| <a name="input_auto_init"></a> [auto\_init](#input\_auto\_init) | (Optional) Set to `true` to produce an initial commit in the repository | `bool` | `null` | no |
| <a name="input_autolink_references"></a> [autolink\_references](#input\_autolink\_references) | (Optional) The list of autolink references of the repository (key: key\_prefix) | <pre>map(object({<br/>    target_url_template = string<br/>    is_alphanumeric     = optional(bool)<br/>  }))</pre> | `{}` | no |
| <a name="input_branches"></a> [branches](#input\_branches) | (Optional) The list of branches to create (map of name and source branch) | `map(string)` | `null` | no |
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | (Optional) base branch against which all pull requests and code commits are automatically made unless you specify a different branch. **NOTE:** This can only be set after a repository has already been created, and after a correct reference has been created for the target branch inside the repository. This means a user will have to omit this parameter from the initial repository creation and create the target branch inside of the repository prior to setting this attribute. | `string` | `null` | no |
| <a name="input_delete_branch_on_merge"></a> [delete\_branch\_on\_merge](#input\_delete\_branch\_on\_merge) | (Optional) Automatically delete head branch after a pull request is merged. Defaults to `false`. | `bool` | `null` | no |
| <a name="input_dependabot_secrets"></a> [dependabot\_secrets](#input\_dependabot\_secrets) | (Optional) The list of secrets configuration of the repository (key: `secret_name`, arguments: `encrypted_value` or `plaintext_value`) | <pre>map(object({<br/>    encrypted_value = optional(string)<br/>    plaintext_value = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_dependabot_security_updates"></a> [dependabot\_security\_updates](#input\_dependabot\_security\_updates) | (Optional) Set to `true` to enable the automated security fixes. | `bool` | `null` | no |
| <a name="input_deploy_keys"></a> [deploy\_keys](#input\_deploy\_keys) | (Optional) The list of deploy keys of the repository (key: key\_title) | <pre>map(object({<br/>    key       = optional(string) # auto-generated if not provided<br/>    read_only = optional(bool, true)<br/>  }))</pre> | `null` | no |
| <a name="input_deploy_keys_path"></a> [deploy\_keys\_path](#input\_deploy\_keys\_path) | (Optional) The path to the generated deploy keys for this repository | `string` | `"./deploy_keys"` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the repository | `string` | `null` | no |
| <a name="input_environments"></a> [environments](#input\_environments) | (Optional) The list of environments configuration of the repository (key: environment\_name) | <pre>map(object({<br/>    wait_timer             = optional(number)<br/>    can_admins_bypass      = optional(bool)<br/>    prevent_self_review    = optional(bool)<br/>    reviewers_users        = optional(list(string), [])<br/>    reviewers_teams        = optional(list(string), [])<br/>    protected_branches     = optional(bool)<br/>    custom_branch_policies = optional(list(string))<br/>    secrets = optional(map(object({<br/>      encrypted_value = optional(string)<br/>      plaintext_value = optional(string)<br/>    })))<br/>    variables = optional(map(string))<br/>  }))</pre> | `null` | no |
| <a name="input_files"></a> [files](#input\_files) | (Optional) The list of files of the repository (key: file\_path) | <pre>map(object({<br/>    content             = optional(string)<br/>    from_file           = optional(string)<br/>    branch              = optional(string)<br/>    commit_author       = optional(string)<br/>    commit_email        = optional(string)<br/>    commit_message      = optional(string)<br/>    overwrite_on_create = optional(bool, true)<br/>  }))</pre> | `null` | no |
| <a name="input_gitignore_template"></a> [gitignore\_template](#input\_gitignore\_template) | (Optional) Use the [name of the template](https://github.com/github/gitignore) without the extension. For example, `Haskell`. | `string` | `null` | no |
| <a name="input_has_discussions"></a> [has\_discussions](#input\_has\_discussions) | (Optional) Set to `true` to enable GitHub Discussions on the repository. Defaults to `false` | `bool` | `null` | no |
| <a name="input_has_issues"></a> [has\_issues](#input\_has\_issues) | (Optional) Set to `true` to enable the GitHub Issues features on the repository. | `bool` | `null` | no |
| <a name="input_has_projects"></a> [has\_projects](#input\_has\_projects) | (Optional) Set to `true` to enable the GitHub Projects features on the repository. Per the GitHub documentation when in an organization that has disabled repository projects it will default to `false` and will otherwise default to `true`. If you specify true when it has been disabled it will return an error. | `bool` | `null` | no |
| <a name="input_has_wiki"></a> [has\_wiki](#input\_has\_wiki) | (Optional) Set to `true` to enable the GitHub Wiki features on the repository. | `bool` | `null` | no |
| <a name="input_homepage_url"></a> [homepage\_url](#input\_homepage\_url) | (Optional) URL of a page describing the project | `string` | `null` | no |
| <a name="input_ignore_vulnerability_alerts_during_read"></a> [ignore\_vulnerability\_alerts\_during\_read](#input\_ignore\_vulnerability\_alerts\_during\_read) | (Optional) - Set to `true` to not call the vulnerability alerts endpoint so the resource can also be used without admin permissions during read. | `bool` | `null` | no |
| <a name="input_is_template"></a> [is\_template](#input\_is\_template) | (Optional) Set to `true` if this is a template repository | `bool` | `null` | no |
| <a name="input_issue_labels"></a> [issue\_labels](#input\_issue\_labels) | (Optional) The list of issue labels of the repository (key: `label_name`, arguments: `color` and `description`) | <pre>map(object({<br/>    color       = optional(string)<br/>    description = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_license_template"></a> [license\_template](#input\_license\_template) | (Optional) Use the [name of the template](https://github.com/github/choosealicense.com/tree/gh-pages/_licenses) without the extension. For example, `mit` or `mpl-2.0`. | `string` | `null` | no |
| <a name="input_merge_commit_message"></a> [merge\_commit\_message](#input\_merge\_commit\_message) | (Optional) Can be `PR_BODY`, `PR_TITLE`, or `BLANK` for a default merge commit message. Applicable only if `allow_merge_commit` is `true`. | `string` | `null` | no |
| <a name="input_merge_commit_title"></a> [merge\_commit\_title](#input\_merge\_commit\_title) | (Optional) Can be `PR_TITLE` or `MERGE_MESSAGE` for a default merge commit title. Applicable only if `allow_merge_commit` is `true`. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the repository | `string` | n/a | yes |
| <a name="input_pages"></a> [pages](#input\_pages) | (Optional) The repository's GitHub Pages configuration. Supports the following: `source_branch` - (Optional) The repository branch used to publish the site's source files. (i.e. main or gh-pages).; `source_path` -  (Optional) The repository directory from which the site publishes (Default: `/`).; (Optional) The type of GitHub Pages site to build. Can be `legacy` or `workflow`. If you use `legacy` as build type you need to set the option `source_branch`.; `cname` - (Optional) The custom domain for the repository. This can only be set after the repository has been created. | <pre>object({<br/>    source_branch = optional(string)<br/>    source_path   = optional(string)<br/>    build_type    = optional(string, "workflow")<br/>    cname         = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_private"></a> [private](#input\_private) | (Optional) Set to `true` to create a private repository. Repositories are created as public (e.g. open source) by default. | `bool` | `null` | no |
| <a name="input_properties"></a> [properties](#input\_properties) | (Optional) The list of properties of the repository (key: property\_name) | `any` | `null` | no |
| <a name="input_properties_types"></a> [properties\_types](#input\_properties\_types) | (Optional) The list of types associated to properties (key: property\_name) | `map(string)` | `null` | no |
| <a name="input_rulesets"></a> [rulesets](#input\_rulesets) | (Optional) Repository rules | <pre>map(object({<br/>    enforcement                          = optional(string, "active")<br/>    target                               = optional(string, "branch")<br/>    include                              = optional(list(string), [])<br/>    exclude                              = optional(list(string), [])<br/>    bypass_mode                          = optional(string, "always")<br/>    bypass_organization_admin            = optional(bool)<br/>    bypass_roles                         = optional(list(string))<br/>    bypass_teams                         = optional(list(string))<br/>    bypass_integration                   = optional(list(string))<br/>    regex_branch_name                    = optional(string)<br/>    regex_tag_name                       = optional(string)<br/>    regex_commit_author_email            = optional(string)<br/>    regex_committer_email                = optional(string)<br/>    regex_commit_message                 = optional(string)<br/>    forbidden_creation                   = optional(bool)<br/>    forbidden_deletion                   = optional(bool)<br/>    forbidden_update                     = optional(bool)<br/>    forbidden_fast_forward               = optional(bool)<br/>    dismiss_pr_stale_reviews_on_push     = optional(bool)<br/>    required_pr_code_owner_review        = optional(bool)<br/>    required_pr_last_push_approval       = optional(bool)<br/>    required_pr_approving_review_count   = optional(number)<br/>    required_pr_review_thread_resolution = optional(bool)<br/>    required_deployment_environments     = optional(list(string))<br/>    required_linear_history              = optional(bool)<br/>    required_signatures                  = optional(bool)<br/>    required_checks                      = optional(list(string))<br/>    required_code_scanning = optional(map(object({ # index is name of tool<br/>      alerts_threshold          = optional(string)<br/>      security_alerts_threshold = optional(string)<br/>    })))<br/>  }))</pre> | `null` | no |
| <a name="input_secret_scanning"></a> [secret\_scanning](#input\_secret\_scanning) | (Optional) Set to `true` to enable secret scanning on the repository. If set to `true`, the repository's visibility must be `public` or `advanced_security` must also be `true`. | `bool` | `null` | no |
| <a name="input_secret_scanning_push_protection"></a> [secret\_scanning\_push\_protection](#input\_secret\_scanning\_push\_protection) | (Optional) Set to `true` to enable secret scanning push protection on the repository. If set to `true`, the repository's visibility must be `public` or `advanced_security` must also be `true`. | `bool` | `null` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | (Optional) The list of secrets configuration of the repository (key: secret\_name) | <pre>map(object({<br/>    encrypted_value = optional(string)<br/>    plaintext_value = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_squash_merge_commit_message"></a> [squash\_merge\_commit\_message](#input\_squash\_merge\_commit\_message) | (Optional) Can be `PR_BODY`, `COMMIT_MESSAGES`, or `BLANK` for a default squash merge commit message. Applicable only if `allow_squash_merge` is `true`. | `string` | `null` | no |
| <a name="input_squash_merge_commit_title"></a> [squash\_merge\_commit\_title](#input\_squash\_merge\_commit\_title) | (Optional) Can be `PR_TITLE` or `COMMIT_OR_PR_TITLE` for a default squash merge commit title. Applicable only if `allow_squash_merge` is `true`. | `string` | `null` | no |
| <a name="input_teams"></a> [teams](#input\_teams) | (Optional) The list of collaborators (teams) of the repository | `map(string)` | `null` | no |
| <a name="input_template"></a> [template](#input\_template) | (Optional) Use a template repository to create this resource (owner/repo) | `string` | `null` | no |
| <a name="input_template_include_all_branches"></a> [template\_include\_all\_branches](#input\_template\_include\_all\_branches) | (Optional) Whether the new repository should include all the branches from the template repository (defaults to false, which includes only the default branch from the template). | `bool` | `null` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | (Optional) The list of topics of the repository | `list(string)` | `null` | no |
| <a name="input_users"></a> [users](#input\_users) | (Optional) The list of collaborators (users) of the repository | `map(string)` | `null` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | (Optional) The list of variables configuration of the repository (key: variable\_name) | `map(string)` | `null` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | (Optional) Can be `public` or `private` (or `internal` if your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+). The visibility parameter overrides the `private` parameter. | `string` | `null` | no |
| <a name="input_vulnerability_alerts"></a> [vulnerability\_alerts](#input\_vulnerability\_alerts) | (Optional) - Set to `true` to enable security alerts for vulnerable dependencies. Enabling requires alerts to be enabled on the owner level. See [GitHub Documentation](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository#allow_squash_merge-1:~:text=(Optional)%20%2D%20Set%20to,in%20those%20settings.) for details. Note that vulnerability alerts have not been successfully tested on any GitHub Enterprise instance and may be unavailable in those settings. | `bool` | `null` | no |
| <a name="input_web_commit_signoff_required"></a> [web\_commit\_signoff\_required](#input\_web\_commit\_signoff\_required) | (Optional) Require contributors to sign off on web-based commits. See more here. Defaults to `false` | `bool` | `null` | no |
| <a name="input_webhooks"></a> [webhooks](#input\_webhooks) | (Optional) The list of webhooks of the repository (key: webhook\_url) | <pre>map(object({<br/>    content_type = string<br/>    insecure_ssl = optional(bool, false)<br/>    secret       = optional(string)<br/>    events       = optional(list(string))<br/>  }))</pre> | `null` | no |

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
