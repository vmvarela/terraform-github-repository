variable "name" {
  description = "(Required) The name of the repository"
  type        = string
}

variable "alias" {
  description = "(Optional) The original name of the repository (useful for renaming)"
  type        = string
  default     = null
}

variable "description" {
  description = "(Optional) A description of the repository"
  type        = string
  default     = null
}

variable "homepage_url" {
  description = "(Optional) URL of a page describing the project"
  type        = string
  default     = null
}

variable "private" {
  description = "(Optional) Set to `true` to create a private repository. Repositories are created as public (e.g. open source) by default."
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
  description = "(Optional) Set to `true` to enable the GitHub Issues features on the repository."
  type        = bool
  default     = null
}

variable "has_discussions" {
  description = "(Optional) Set to `true` to enable GitHub Discussions on the repository. Defaults to `false`"
  type        = bool
  default     = null
}

variable "has_projects" {
  description = "(Optional) Set to `true` to enable the GitHub Projects features on the repository. Per the GitHub documentation when in an organization that has disabled repository projects it will default to `false` and will otherwise default to `true`. If you specify true when it has been disabled it will return an error."
  type        = bool
  default     = null
}

variable "has_wiki" {
  description = "(Optional) Set to `true` to enable the GitHub Wiki features on the repository."
  type        = bool
  default     = null
}

variable "is_template" {
  description = "(Optional) Set to `true` if this is a template repository"
  type        = bool
  default     = null
}

variable "allow_merge_commit" {
  description = "(Optional) Set to `false` to disable merge commits on the repository."
  type        = bool
  default     = null
}

variable "allow_squash_merge" {
  description = "(Optional) Set to `false` to disable squash merges on the repository."
  type        = bool
  default     = null
}

variable "allow_rebase_merge" {
  description = "(Optional) Set to `false` to disable rebase merges on the repository."
  type        = bool
  default     = null
}

variable "allow_auto_merge" {
  description = "(Optional) Set to `true` to allow auto-merging pull requests on the repository."
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

variable "delete_branch_on_merge" {
  description = "(Optional) Automatically delete head branch after a pull request is merged. Defaults to `false`."
  type        = bool
  default     = null
}

variable "web_commit_signoff_required" {
  description = "(Optional) Require contributors to sign off on web-based commits. See more here. Defaults to `false`"
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

variable "default_branch" {
  description = "(Optional) base branch against which all pull requests and code commits are automatically made unless you specify a different branch. **NOTE:** This can only be set after a repository has already been created, and after a correct reference has been created for the target branch inside the repository. This means a user will have to omit this parameter from the initial repository creation and create the target branch inside of the repository prior to setting this attribute."
  type        = string
  default     = null
}

variable "archived" {
  description = "(Optional) Specifies if the repository should be archived. Defaults to `false`. **NOTE:** Currently, the API does not support unarchiving."
  type        = bool
  default     = null
}

variable "archive_on_destroy" {
  description = "(Optional) Set to `true` to archive the repository instead of deleting on destroy."
  type        = bool
  default     = null
}

variable "topics" {
  description = "(Optional) The list of topics of the repository"
  type        = list(string)
  default     = null
}

variable "vulnerability_alerts" {
  description = "(Optional) - Set to `true` to enable security alerts for vulnerable dependencies. Enabling requires alerts to be enabled on the owner level. See [GitHub Documentation](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository#allow_squash_merge-1:~:text=(Optional)%20%2D%20Set%20to,in%20those%20settings.) for details. Note that vulnerability alerts have not been successfully tested on any GitHub Enterprise instance and may be unavailable in those settings."
  type        = bool
  default     = null
}

variable "ignore_vulnerability_alerts_during_read" {
  description = "(Optional) - Set to `true` to not call the vulnerability alerts endpoint so the resource can also be used without admin permissions during read."
  type        = bool
  default     = null
}

variable "allow_update_branch" {
  description = "(Optional) - Set to `true` to always suggest updating pull request branches."
  type        = bool
  default     = null
}

variable "pages" {
  description = "(Optional) The repository's GitHub Pages configuration. Supports the following: `source_branch` - (Optional) The repository branch used to publish the site's source files. (i.e. main or gh-pages).; `source_path` -  (Optional) The repository directory from which the site publishes (Default: `/`).; (Optional) The type of GitHub Pages site to build. Can be `legacy` or `workflow`. If you use `legacy` as build type you need to set the option `source_branch`.; `cname` - (Optional) The custom domain for the repository. This can only be set after the repository has been created."
  type = object({
    source_branch = optional(string)
    source_path   = optional(string)
    build_type    = optional(string, "workflow")
    cname         = optional(string)
  })
  default = null
  validation {
    condition     = var.pages == null || can(regex("^legacy$|^workflow$", var.pages.build_type))
    error_message = "pages.build_type must be legacy or workflow. If you use legacy as build type you need to set the option source_branch."
  }
}

variable "advanced_security" {
  description = "(Optional) Set to `true` to enable advanced security features on the repository."
  type        = bool
  default     = null
}

variable "secret_scanning" {
  description = "(Optional) Set to `true` to enable secret scanning on the repository. If set to `true`, the repository's visibility must be `public` or `advanced_security` must also be `true`."
  type        = bool
  default     = null
}

variable "secret_scanning_push_protection" {
  description = "(Optional) Set to `true` to enable secret scanning push protection on the repository. If set to `true`, the repository's visibility must be `public` or `advanced_security` must also be `true`."
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

variable "actions_access_level" {
  description = "(Optional) The access level for the repository. Must be one of `none`, `user`, `organization`, or `enterprise`. Default: `none`"
  type        = string
  default     = null
  validation {
    condition     = var.actions_access_level == null || can(regex("^none$|^user$|^organization$|^enterprise$", var.actions_access_level))
    error_message = "Only none, user, organization and enterprise values are allowed"
  }
}

variable "actions_permissions" {
  description = "(Optional) The list of Github Actions permissions configuration of the repository: `allowed_actions` - (Optional) The permissions policy that controls the actions that are allowed to run. Can be one of: `all`, `local_only`, or `selected`.; `enabled` - (Optional) Should GitHub actions be enabled on this repository?; `github_owned_allowed` - (Optional) Whether GitHub-owned actions are allowed in the repository.; `patterns_allowed` - (Optional) Specifies a list of string-matching patterns to allow specific action(s). Wildcards, tags, and SHAs are allowed. For example, monalisa/octocat@, monalisa/octocat@v2, monalisa/.; `verified_allowed` -  (Optional) Whether actions in GitHub Marketplace from verified creators are allowed. Set to true to allow all GitHub Marketplace actions by verified creators."
  type = object({
    enabled              = optional(bool)
    allowed_actions      = optional(string)
    github_owned_allowed = optional(bool)
    patterns_allowed     = optional(list(string))
    verified_allowed     = optional(bool)
  })
  default = null
  validation {
    condition     = var.actions_permissions == null || try(var.actions_permissions.allowed_actions, null) == null || can(regex("^all$|^local_only$|^selected$", var.actions_permissions.allowed_actions))
    error_message = "permissions.allowed_actions: Only all, local_only and selected values are allowed"
  }
}

variable "branches" {
  description = "(Optional) The list of branches to create (map of name and source branch)"
  type        = map(string)
  default     = null
}

variable "dependabot_security_updates" {
  description = "(Optional) Set to `true` to enable the automated security fixes."
  type        = bool
  default     = null
}

variable "issue_labels" {
  description = "(Optional) The list of issue labels of the repository (key: label_name)"
  type = map(object({
    color       = string
    description = optional(string)
  }))
  default = null
}



# Collaborators

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


# Topics



# Rules

variable "rulesets" {
  description = "(Optional) Repository rules"
  type = map(object({
    enforcement = optional(string, "active")
    target      = optional(string, "branch")
    include     = optional(list(string), [])
    exclude     = optional(list(string), [])
    bypass_actors = optional(map(object({
      actor_type  = string
      bypass_mode = string
    })))
    rules = optional(object({
      branch_name_pattern = optional(object({
        operator = optional(string)
        pattern  = optional(string)
        name     = optional(string)
        negate   = optional(bool)
      }))
      tag_name_pattern = optional(object({
        operator = optional(string)
        pattern  = optional(string)
        name     = optional(string)
        negate   = optional(bool)
      }))
      commit_author_email_pattern = optional(object({
        operator = optional(string)
        pattern  = optional(string)
        name     = optional(string)
        negate   = optional(bool)
      }))
      commit_message_pattern = optional(object({
        operator = optional(string)
        pattern  = optional(string)
        name     = optional(string)
        negate   = optional(bool)
      }))
      committer_email_pattern = optional(object({
        operator = optional(string)
        pattern  = optional(string)
        name     = optional(string)
        negate   = optional(bool)
      }))
      creation         = optional(bool)
      deletion         = optional(bool)
      non_fast_forward = optional(bool)
      pull_request = optional(object({
        dismiss_stale_reviews_on_push     = optional(bool)
        require_code_owner_review         = optional(bool)
        require_last_push_approval        = optional(bool)
        required_approving_review_count   = optional(number)
        required_review_thread_resolution = optional(bool)
      }))
      required_deployment_environments     = optional(list(string))
      required_linear_history              = optional(bool)
      required_signatures                  = optional(bool)
      required_status_checks               = optional(map(string))
      strict_required_status_checks_policy = optional(bool)
      update                               = optional(bool)
      update_allows_fetch_and_merge        = optional(bool)
    }))
  }))
  default = {}
  validation {
    condition     = alltrue([for name, config in(var.rulesets == null ? {} : var.rulesets) : contains(["active", "evaluate", "disabled"], config.enforcement)])
    error_message = "Possible values for enforcement are active, evaluate or disabled."
  }
  validation {
    condition     = alltrue([for name, config in(var.rulesets == null ? {} : var.rulesets) : contains(["tag", "branch"], config.target)])
    error_message = "Possible values for ruleset target are tag or branch"
  }
}


# Actions




# Webhooks

variable "webhooks" {
  description = "(Optional) The list of webhooks of the repository (key: webhook_url)"
  type = map(object({
    content_type = string
    insecure_ssl = optional(bool, false)
    secret       = optional(string)
    events       = optional(list(string))
  }))
  default = null
  validation {
    condition     = alltrue([for url, config in(var.webhooks == null ? {} : var.webhooks) : contains(["form", "json"], config.content_type)])
    error_message = "Possible values for content_type are json or form."
  }
}


# Environments

variable "environments" {
  description = "(Optional) The list of environments configuration of the repository (key: environment_name)"
  type = map(object({
    wait_timer          = optional(number)
    can_admins_bypass   = optional(bool)
    prevent_self_review = optional(bool)
    reviewers = optional(object({
      users = optional(list(string), [])
      teams = optional(list(string), [])
    }))
    deployment_branch_policy = optional(object({
      protected_branches     = optional(bool, false)
      custom_branch_policies = optional(list(string), [])
    }))
    secrets = optional(map(object({
      encrypted_value = optional(string)
      plaintext_value = optional(string)
    })))
    variables = optional(map(string))
  }))
  default = null
}


# Pages



# Custom properties

variable "properties" {
  description = "(Optional) The list of properties of the repository (key: property_name)"
  type        = any
  default     = null
}

variable "properties_types" {
  description = "(Optional) The list of types associated to properties (key: property_name)"
  type        = map(string)
  default     = null
  validation {
    condition     = alltrue([for property_name, property_type in(var.properties_types == null ? {} : var.properties_types) : contains(["single_select", "multi_select", "string", "true_false"], property_type)])
    error_message = "Possible values for property type are single_select, multi_select, string or true_false"
  }
}


# Deploy keys

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


# Secrets and variables

variable "secrets" {
  description = "(Optional) The list of secrets configuration of the repository (key: secret_name)"
  type = map(object({
    encrypted_value = optional(string)
    plaintext_value = optional(string)
  }))
  default = null
}

variable "variables" {
  description = "(Optional) The list of variables configuration of the repository (key: variable_name)"
  type        = map(string)
  default     = null
}


# Other

variable "autolink_references" {
  description = "(Optional) The list of autolink references of the repository (key: key_prefix)"
  type = map(object({
    target_url_template = string
    is_alphanumeric     = optional(bool)
  }))
  default = {}
}

variable "files" {
  description = "(Optional) The list of files of the repository (key: file_path)"
  type = map(object({
    content             = optional(string)
    from_file           = optional(string)
    branch              = optional(string)
    commit_author       = optional(string)
    commit_email        = optional(string)
    commit_message      = optional(string)
    overwrite_on_create = optional(bool, true)
  }))
  default = null
}
