variable "repository" {
  description = "(Required) The repository of the environment."
  type        = string
}

variable "name" {
  description = "(Required) (String) The name of the ruleset."
  type        = string
}

variable "enforcement" {
  description = "(Required) Possible values for Enforcement are `disabled`, `active`, `evaluate`. Note: `evaluate` is currently only supported for owners of type `organization`."
  type        = string
  default     = "active"
  validation {
    condition     = contains(["active", "evaluate", "disabled"], var.enforcement)
    error_message = "Possible values for enforcement are active, evaluate or disabled."
  }
}

variable "target" {
  description = "(Required) Possible values are `branch` and `tag`."
  type        = string
  default     = "branch"
  validation {
    condition     = contains(["tag", "branch"], var.target)
    error_message = "Possible values for ruleset target are tag or branch"
  }
}

variable "include" {
  description = "(Required) Array of ref names or patterns to include. One of these patterns must match for the condition to pass. Also accepts `~DEFAULT_BRANCH` to include the default branch or `~ALL` to include all branches."
  type        = set(string)
  default     = []
}

variable "exclude" {
  description = "(Required) Array of ref names or patterns to exclude. The condition will not pass if any of these patterns match."
  type        = set(string)
  default     = []
}

variable "bypass_mode" {
  description = "(Optional) When the specified actor can bypass the ruleset. `pull_request` means that an actor can only bypass rules on pull requests. Can be one of: `always`, `pull_request`."
  type        = string
  default     = "always"
  validation {
    condition     = contains(["always", "pull_request"], var.bypass_mode)
    error_message = "Possible values for ruleset target are tag or branch"
  }
}

variable "bypass_organization_admin" {
  description = "(Optional) Organization Admin can bypass the rules in this ruleset."
  type        = bool
  default     = null
}

variable "bypass_roles" {
  description = "(Optional) List of repository roles that can bypass the rules in this ruleset."
  type        = set(string)
  default     = []
}

variable "bypass_teams" {
  description = "(Optional) List of teams that can bypass the rules in this ruleset."
  type        = set(string)
  default     = []
}

variable "bypass_integration" {
  description = "(Optional) List of GitHub App IDs that can bypass the rules in this ruleset."
  type        = set(string)
  default     = []
}

variable "regex_target" {
  description = "(Optional) Pattern to match branch or tag. This rule only applies to repositories within an enterprise, it cannot be applied to repositories owned by individuals or regular organizations."
  type        = string
  default     = null
}

variable "regex_commit_author_email" {
  description = "(Optional) Pattern to match author email."
  type        = string
  default     = null
}

variable "regex_committer_email" {
  description = "(Optional) Pattern to match committer email."
  type        = string
  default     = null
}

variable "regex_commit_message" {
  description = "(Optional) Pattern to match commit message."
  type        = string
  default     = null
}

variable "forbidden_creation" {
  description = "(Optional) Only allow users with bypass permission to create matching refs."
  type        = bool
  default     = null
}

variable "forbidden_deletion" {
  description = "(Optional) Only allow users with bypass permissions to delete matching refs."
  type        = bool
  default     = null
}

variable "forbidden_update" {
  description = "(Optional) Only allow users with bypass permission to update matching refs."
  type        = bool
  default     = null
}

variable "forbidden_fast_forward" {
  description = "(Optional) Prevent users with push access from force pushing to branches."
  type        = bool
  default     = null
}

variable "dismiss_pr_stale_reviews_on_push" {
  description = "(Optional) New, reviewable commits pushed will dismiss previous pull request review approvals."
  type        = bool
  default     = null
}

variable "required_pr_code_owner_review" {
  description = "(Optional) Require an approving review in pull requests that modify files that have a designated code owner."
  type        = bool
  default     = null
}

variable "required_pr_last_push_approval" {
  description = "(Optional) Whether the most recent reviewable push must be approved by someone other than the person who pushed it."
  type        = bool
  default     = null
}

variable "required_pr_approving_review_count" {
  description = "(Optional) The number of approving reviews that are required before a pull request can be merged."
  type        = number
  default     = null
}

variable "required_pr_review_thread_resolution" {
  description = "(Optional) All conversations on code must be resolved before a pull request can be merged."
  type        = bool
  default     = null
}

variable "required_deployment_environments" {
  description = "(Optional) The environments that must be successfully deployed to before branches can be merged."
  type        = set(string)
  default     = []
}

variable "required_linear_history" {
  description = "(Optional) Prevent merge commits from being pushed to matching branches."
  type        = bool
  default     = null
}

variable "required_signatures" {
  description = "(Optional) Commits pushed to matching branches must have verified signatures."
  type        = bool
  default     = null
}

variable "required_checks" {
  description = "(Optional) Choose which status checks must pass before branches can be merged into a branch that matches this rule. When enabled, commits must first be pushed to another branch, then merged or pushed directly to a branch that matches this rule after status checks have passed."
  type        = set(string)
  default     = []
}
