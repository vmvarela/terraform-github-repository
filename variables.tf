variable "name" {
  description = "(Required) The name of the repository. Changing this will rename the repository"
  type        = string
}

variable "alias" {
  description = "(Optional) The original name of the repository (useful for renaming in IaC)"
  type        = string
  default     = null
}

variable "description" {
  description = "(Optional) A short description of the repository that will show up on GitHub"
  type        = string
  default     = null
}

variable "homepage" {
  description = "(Optional) A URL with more information about the repository"
  type        = string
  default     = null
}

variable "private" {
  description = "(Optional) Either true to make the repository private or false to make it public. Default: false. **Note:** You will get a 422 error if the organization restricts changing repository visibility to organization owners and a non-owner tries to change the value of private."
  type        = bool
  default     = null
}

variable "visibility" {
  description = "(Optional) Can be `public` or `private` (or `internal` if your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+). The visibility parameter overrides the `private` parameter."
  type        = string
  default     = null
  validation {
    condition     = var.visibility == null || can(regex("^public$|^private$|^internal$", var.visibility))
    error_message = "Only public, private and internal values are allowed"
  }
}

variable "has_issues" {
  description = "(Optional) Either `true` to enable issues for this repository or `false` to disable them."
  type        = bool
  default     = null
}

variable "has_projects" {
  description = "(Optional) Either `true` to enable projects for this repository or `false` to disable them. **Note:** If you're creating a repository in an organization that has disabled repository projects, the default is `false`, and if you pass `true`, the API returns an error."
  type        = bool
  default     = null
}

variable "has_wiki" {
  description = "(Optional) Either `true` to enable the wiki for this repository, `false` to disable it."
  type        = bool
  default     = null
}

variable "has_downloads" {
  description = "(Optional) Whether downloads are enabled."
  type        = bool
  default     = null
}

variable "is_template" {
  description = "(Optional) Either `true` to make this repo available as a template repository or `false` to prevent it."
  type        = bool
  default     = null
}

variable "template" {
  description = "(Optional) Use a template repository to create this resource (owner/repo)"
  type        = string
  default     = null
}

variable "template_include_all_branches" {
  description = "(Optional) Whether the new repository should include all the branches from the template repository (defaults to false, which includes only the default branch from the template)."
  type        = bool
  default     = null
}

variable "auto_init" {
  description = "(Optional) Set to `true` to produce an initial commit in the repository"
  type        = bool
  default     = null
}

variable "gitignore_template" {
  description = "(Optional) Use the [name of the template](https://github.com/github/gitignore) without the extension. For example, `Haskell`."
  type        = string
  default     = null
}

variable "license_template" {
  description = "(Optional) Use the [name of the template](https://github.com/github/choosealicense.com/tree/gh-pages/_licenses) without the extension. For example, `mit` or `mpl-2.0`."
  type        = string
  default     = null
}

variable "allow_squash_merge" {
  description = "(Optional) Either `true` to allow squash-merging pull requests, or `false` to prevent squash-merging."
  type        = bool
  default     = null
}

variable "allow_merge_commit" {
  description = "(Optional) Either `true` to allow merging pull requests with a merge commit, or `false` to prevent merging pull requests with merge commits."
  type        = bool
  default     = null
}

variable "allow_rebase_merge" {
  description = "(Optional) Either `true` to allow rebase-merging pull requests, or `false` to prevent rebase-merging."
  type        = bool
  default     = null
}

variable "allow_auto_merge" {
  description = "(Optional) Set to `true` to allow auto-merging pull requests on the repository."
  type        = bool
  default     = null
}

variable "delete_branch_on_merge" {
  description = "(Optional) Either `true` to enable automatic deletion of branches on merge, or `false` to disable."
  type        = bool
  default     = null
}

variable "allow_update_branch" {
  description = "(Optional) Either `true` to always allow a pull request head branch that is behind its base branch to be updated even if it is not required to be up to date before merging, or `false` otherwise."
  type        = bool
  default     = null
}

variable "squash_merge_commit_title" {
  description = "(Optional) Can be `PR_TITLE` or `COMMIT_OR_PR_TITLE` for a default squash merge commit title. Applicable only if `allow_squash_merge` is `true`."
  type        = string
  default     = null
  validation {
    condition     = var.squash_merge_commit_title == null || can(regex("^PR_TITLE$|^COMMIT_OR_PR_TITLE$", var.squash_merge_commit_title))
    error_message = "Allowed values in squash_merge_commit_title: PR_TITLE or COMMIT_OR_PR_TITLE"
  }
}

variable "squash_merge_commit_message" {
  description = "(Optional) Can be `PR_BODY`, `COMMIT_MESSAGES`, or `BLANK` for a default squash merge commit message. Applicable only if `allow_squash_merge` is `true`."
  type        = string
  default     = null
  validation {
    condition     = var.squash_merge_commit_message == null || can(regex("^PR_BODY$|^COMMIT_MESSAGES$|^BLANK$", var.squash_merge_commit_message))
    error_message = "Allowed values in squash_merge_commit_message: PR_BODY, COMMIT_MESSAGES or BLANK"
  }
}

variable "merge_commit_title" {
  description = "(Optional) Can be `PR_TITLE` or `MERGE_MESSAGE` for a default merge commit title. Applicable only if `allow_merge_commit` is `true`."
  type        = string
  default     = null
  validation {
    condition     = var.merge_commit_title == null || can(regex("^PR_TITLE$|^MERGE_MESSAGE$", var.merge_commit_title))
    error_message = "Allowed values in merge_commit_title: PR_TITLE or MERGE_MESSAGE"
  }
}

variable "merge_commit_message" {
  description = "(Optional) Can be `PR_BODY`, `PR_TITLE`, or `BLANK` for a default merge commit message. Applicable only if `allow_merge_commit` is `true`."
  type        = string
  default     = null
  validation {
    condition     = var.merge_commit_message == null || can(regex("^PR_BODY$|^PR_TITLE$|^BLANK$", var.merge_commit_message))
    error_message = "Allowed values in merge_commit_message: PR_BODY, COMMIT_MESSAGES or BLANK"
  }
}

variable "custom_properties" {
  description = "(Optional) The custom properties for the new repository. The keys are the custom property names, and the values are the corresponding custom property values."
  type        = any
  default     = null
}

variable "custom_properties_types" {
  description = "(Optional) The list of types associated to properties (key: property_name)"
  type        = map(string)
  default     = null
  validation {
    condition     = alltrue([for property_name, property_type in(var.custom_properties_types == null ? {} : var.custom_properties_types) : contains(["single_select", "multi_select", "string", "true_false"], property_type)])
    error_message = "Possible values for property type are single_select, multi_select, string or true_false"
  }
}

variable "enable_advanced_security" {
  description = "(Optional) Use to enable or disable GitHub Advanced Security for this repository."
  type        = bool
  default     = null
}

variable "enable_secret_scanning" {
  description = "(Optional) Use to enable or disable secret scanning for this repository. If set to `true`, the repository's visibility must be `public` or `enable_advanced_security` must also be `true`."
  type        = bool
  default     = null
}

variable "enable_secret_scanning_push_protection" {
  description = "(Optional) Use to enable or disable secret scanning push protection for this repository. If set to `true`, the repository's visibility must be `public` or `enable_advanced_security` must also be `true`."
  type        = bool
  default     = null
}

variable "enable_vulnerability_alerts" {
  description = "(Optional) Either `true` to enable vulnerability alerts, or `false` to disable vulnerability alerts."
  type        = bool
  default     = null
}

variable "enable_dependabot_security_updates" {
  description = "(Optional) Set to `true` to enable the automated security fixes."
  type        = bool
  default     = null
}

variable "default_branch" {
  description = "(Optional) Updates the default branch for this repository."
  type        = string
  default     = null
}

variable "archived" {
  description = "(Optional) Whether to archive this repository. `false` will unarchive a previously archived repository."
  type        = bool
  default     = null
}

variable "archive_on_destroy" {
  description = "(Optional) Set to `true` to archive the repository instead of deleting on destroy."
  type        = bool
  default     = null
}

variable "web_commit_signoff_required" {
  description = "(Optional) Require contributors to sign off on web-based commits. See more here. Defaults to `false`"
  type        = bool
  default     = null
}

variable "topics" {
  description = "(Optional) A list of topics to set on the repository"
  type        = set(string)
  default     = null
}

variable "pages_source_branch" {
  description = "(Optional) The repository branch used to publish the site's source files. (i.e. `main` or `gh-pages`)"
  type        = string
  default     = null
}

variable "pages_source_path" {
  description = "(Optional) The repository directory from which the site publishes (Default: `/`)."
  type        = string
  default     = null
}

variable "pages_build_type" {
  description = "(Optional) The type of GitHub Pages site to build. Can be `legacy` or `workflow`. If you use `legacy` as build type you need to set the option `pages_source_branch`."
  type        = string
  default     = null
  validation {
    condition     = var.pages_build_type == null || can(regex("^legacy$|^workflow$", var.pages_build_type))
    error_message = "pages_build_type must be legacy or workflow."
  }
  validation {
    condition     = var.pages_build_type != "legacy" || var.pages_source_branch != null
    error_message = "If you use legacy as build type you need to set the option pages_source_branch."
  }
}

variable "pages_cname" {
  description = "(Optional) The custom domain for the repository. This can only be set after the repository has been created."
  type        = string
  default     = null
}

variable "actions_access_level" {
  description = "(Optional) The access level for the repository. Must be one of `none`, `user`, `organization`, or `enterprise`. Default: `none`"
  type        = string
  default     = null
  validation {
    condition     = var.actions_access_level == null || can(regex("^none$|^user$|^organization$|^enterprise$", var.actions_access_level))
    error_message = "Only none, user, organization and enterprise values are allowed"
  }
}

variable "enable_actions" {
  description = "(Optional) Either `true` to enable Github Actions, or `false` to disable."
  type        = bool
  default     = null
}

variable "actions_allowed_policy" {
  description = "(Optional) The permissions policy that controls the actions that are allowed to run. Can be one of: `all`, `local_only`, or `selected`."
  type        = string
  default     = null
  validation {
    condition     = var.actions_access_level == null || can(regex("^all$|^local_only$|^selected$", var.actions_allowed_policy))
    error_message = "Can be one of: all, local_only, or selected."
  }
}

variable "actions_allowed_github" {
  description = "(Optional) Whether GitHub-owned actions are allowed in the repository. Only available when `actions_allowed_policy` = `selected`."
  type        = bool
  default     = true
}

variable "actions_allowed_patterns" {
  description = "(Optional) Specifies a list of string-matching patterns to allow specific action(s). Wildcards, tags, and SHAs are allowed. For example, `monalisa/octocat@`, `monalisa/octocat@v2`, `monalisa/`."
  type        = set(string)
  default     = null
}

variable "actions_allowed_verified" {
  description = "(Optional) Whether actions in GitHub Marketplace from verified creators are allowed. Set to `true` to allow all GitHub Marketplace actions by verified creators. Only available when `actions_allowed_policy` = `selected`."
  type        = bool
  default     = null
}

variable "branches" {
  description = "(Optional) The list of branches to create (map of name and source branch)"
  type        = map(string)
  default     = null
}

variable "dependabot_secrets" {
  description = "(Optional) The list of secrets configuration of the repository (key: `secret_name`). Only plaintext secrets."
  type        = map(string)
  default     = null
}

variable "dependabot_secrets_encrypted" {
  description = "(Optional) The list of secrets configuration of the repository (key: `secret_name`). Only encrypted secrets."
  type        = map(string)
  default     = null
}

variable "dependabot_copy_secrets" {
  description = "(Optional) If dependabot uses same repository secrets (plaintext or encrypted). Makes a copy."
  type        = bool
  default     = false
}

variable "issue_labels" {
  description = "(Optional) The list of issue labels of the repository (key: `label_name`, arguments: `color` and `description`)"
  type = map(object({
    color       = optional(string)
    description = optional(string)
  }))
  default = null
}

variable "autolink_references" {
  description = "(Optional) The list of autolink references of the repository (key: key_prefix)"
  type = map(object({
    target_url_template = string
    is_alphanumeric     = optional(bool)
  }))
  default = {}
}

variable "users" {
  description = "(Optional) The list of collaborators (users) of the repository"
  type        = map(string)
  default     = null
}

variable "teams" {
  description = "(Optional) The list of collaborators (teams) of the repository"
  type        = map(string)
  default     = null
}

variable "files" {
  description = "(Optional) The list of files of the repository (key: file_path). See [file module](./modules/file/README.md) for arguments."
  type        = list(any)
  default     = null
}

variable "environments" {
  description = "(Optional) The list of environments configuration of the repository (key: environment_name)"
  type = map(object({
    wait_timer             = optional(number)
    can_admins_bypass      = optional(bool)
    prevent_self_review    = optional(bool)
    reviewers_users        = optional(set(string), [])
    reviewers_teams        = optional(set(string), [])
    protected_branches     = optional(bool)
    custom_branch_policies = optional(set(string))
    secrets                = optional(map(string))
    secrets_encrypted      = optional(map(string))
    variables              = optional(map(string))
  }))
  default = null
}

variable "deploy_keys" {
  description = "(Optional) The list of deploy keys of the repository (key: key_title)"
  type = map(object({
    key       = optional(string) # auto-generated if not provided
    read_only = optional(bool, true)
  }))
  default = null
}

variable "deploy_keys_path" {
  description = "(Optional) The path to the generated deploy keys for this repository"
  type        = string
  default     = "./deploy_keys"
}

variable "rulesets" {
  description = "(Optional) Repository rules"
  type = map(object({
    enforcement                          = optional(string, "active")
    target                               = optional(string, "branch")
    include                              = optional(set(string), [])
    exclude                              = optional(set(string), [])
    bypass_mode                          = optional(string, "always")
    bypass_organization_admin            = optional(bool)
    bypass_roles                         = optional(set(string))
    bypass_teams                         = optional(set(string))
    bypass_integration                   = optional(set(string))
    regex_branch_name                    = optional(string)
    regex_tag_name                       = optional(string)
    regex_commit_author_email            = optional(string)
    regex_committer_email                = optional(string)
    regex_commit_message                 = optional(string)
    forbidden_creation                   = optional(bool)
    forbidden_deletion                   = optional(bool)
    forbidden_update                     = optional(bool)
    forbidden_fast_forward               = optional(bool)
    dismiss_pr_stale_reviews_on_push     = optional(bool)
    required_pr_code_owner_review        = optional(bool)
    required_pr_last_push_approval       = optional(bool)
    required_pr_approving_review_count   = optional(number)
    required_pr_review_thread_resolution = optional(bool)
    required_deployment_environments     = optional(set(string))
    required_linear_history              = optional(bool)
    required_signatures                  = optional(bool)
    required_checks                      = optional(set(string))
    required_code_scanning = optional(map(object({ # index is name of tool
      alerts_threshold          = optional(string)
      security_alerts_threshold = optional(string)
    })))
  }))
  default = null
  validation {
    condition     = alltrue([for name, config in(var.rulesets == null ? {} : var.rulesets) : contains(["active", "evaluate", "disabled"], config.enforcement)])
    error_message = "Possible values for enforcement are active, evaluate or disabled."
  }
  validation {
    condition     = alltrue([for name, config in(var.rulesets == null ? {} : var.rulesets) : contains(["tag", "branch"], config.target)])
    error_message = "Possible values for ruleset target are tag or branch"
  }
  validation {
    condition     = alltrue([for name, config in(var.rulesets == null ? {} : var.rulesets) : contains(["always", "pull_request"], config.bypass_mode)])
    error_message = "Possible values for ruleset bypass_mode are always or pull_request"
  }
}

variable "webhooks" {
  description = "(Optional) The list of webhooks of the repository. See [webhook module](./modules/webhook/README.md) for arguments."
  type        = list(any)
  default     = null
}

variable "secrets" {
  description = "(Optional) The list of secrets configuration of the repository (key: secret_name). Only plaintext secrets."
  type        = map(string)
  default     = null
}

variable "secrets_encrypted" {
  description = "(Optional) The list of secrets configuration of the repository (key: secret_name). Only encrypted secrets."
  type        = map(string)
  default     = null
}

variable "variables" {
  description = "(Optional) The list of variables configuration of the repository (key: variable_name)"
  type        = map(string)
  default     = null
}
