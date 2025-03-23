variable "repository" {
  description = "(Required) The repository to create the file in."
  type        = string
}

variable "file" {
  description = "(Required) The path of the file to manage."
  type        = string
}

variable "content" {
  description = "(Optional) The file content."
  type        = string
  default     = null
}

variable "from_file" {
  description = "(Optional) File to load content from"
  type        = string
  default     = null
}

variable "branch" {
  description = "(Optional) Git branch (defaults to the repository's default branch). The branch must already exist, it will only be created automatically if `autocreate_branch` is set `true`."
  type        = string
  default     = null
}

variable "commit_author" {
  description = "(Optional) Committer author name to use. NOTE: GitHub app users may omit author and email information so GitHub can verify commits as the GitHub App. This maybe useful when a branch protection rule requires signed commits."
  type        = string
  default     = null
}

variable "commit_email" {
  description = "(Optional) Committer email address to use. NOTE: GitHub app users may omit author and email information so GitHub can verify commits as the GitHub App. This may be useful when a branch protection rule requires signed commits."
  type        = string
  default     = null
}

variable "commit_message" {
  description = "(Optional) The commit message when creating, updating or deleting the managed file."
  type        = string
  default     = null
}

variable "overwrite_on_create" {
  description = "(Optional) Enable overwriting existing files. If set to `true` it will overwrite an existing file with the same name. If set to `false` it will fail if there is an existing file with the same name"
  type        = bool
  default     = null
}

variable "autocreate_branch" {
  description = "(Optional) Automatically create the branch if it could not be found. Defaults to `false`. Subsequent reads if the branch is deleted will occur from `autocreate_branch_source_branch`."
  type        = bool
  default     = null
}

variable "autocreate_branch_source_branch" {
  description = "(Optional) The branch name to start from, if `autocreate_branch` is set. Defaults to `main`."
  type        = string
  default     = null
}

variable "autocreate_branch_source_sha" {
  description = "(Optional) The commit hash to start from, if `autocreate_branch` is set. Defaults to the tip of `autocreate_branch_source_branch`. If provided, `autocreate_branch_source_branch` is ignored."
  type        = string
  default     = null
}
