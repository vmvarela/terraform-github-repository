module "repo" {
  source         = "../.."
  name           = "test-repository-simple"
  visibility     = "private"
  default_branch = "master"
  topics         = ["terraform-test"]
  template       = "vmvarela/template"
  branches = {
    "develop" = "master"
  }
  archived                 = false
  archive_on_destroy       = false
  enable_actions           = true
  actions_allowed_policy   = "selected"
  actions_allowed_verified = true
  webhooks = [
    {
      url          = "https://www.google.es"
      events       = ["issues"]
      content_type = "form"
    }
  ]
  files = [
    {
      file                = ".gitignore"
      content             = "**/*.tfstate"
      commit_message      = "Managed by Terraform"
      commit_author       = "Terraform User"
      commit_email        = "terraform@example.com"
      overwrite_on_create = true
    }
  ]
  issue_labels = {
    "good-first-issue" = "Good for begginners in this project"
  }
}
