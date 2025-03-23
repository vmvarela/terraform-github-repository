variable "repository" {
  description = "(Required) The repository of the environment."
  type        = string
}

variable "environment" {
  description = "(Required) The name of the environment."
  type        = string
}

variable "wait_timer" {
  description = "(Optional) Amount of time to delay a job after the job is initially triggered."
  type        = number
  default     = null
}

variable "can_admins_bypass" {
  description = "(Optional) Can repository admins bypass the environment protections. Defaults to `true`."
  type        = bool
  default     = true
}

variable "prevent_self_review" {
  description = "(Optional) Whether or not a user who created the job is prevented from approving their own job. Defaults to `false`."
  type        = bool
  default     = false
}

variable "reviewers_teams" {
  description = "(Optional) Up to 6 IDs for teams who may review jobs that reference the environment. Reviewers must have at least read access to the repository. Only one of the required reviewers needs to approve the job for it to proceed."
  type        = set(string)
  default     = []
}

variable "reviewers_users" {
  description = "(Optional) Up to 6 IDs for users who may review jobs that reference the environment. Reviewers must have at least read access to the repository. Only one of the required reviewers needs to approve the job for it to proceed."
  type        = set(string)
  default     = []
}

variable "protected_branches" {
  description = "(Optional) Whether only branches with branch protection rules can deploy to this environment."
  type        = bool
  default     = null
}

variable "custom_branch_policies" {
  description = "(Required) Whether only branches that match the specified name patterns can deploy to this environment."
  type        = set(string)
  default     = null
}

variable "secrets" {
  description = "(Optional)"
  type        = map(string)
  default     = null
}

variable "secrets_encrypted" {
  description = "(Optional)"
  type        = map(string)
  default     = null
}

variable "variables" {
  description = "(Optional)"
  type        = map(string)
  default     = null
}
