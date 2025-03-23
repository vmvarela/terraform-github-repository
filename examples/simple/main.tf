module "repo" {
  source         = "../.."
  name           = "test-repository-simple"
  visibility     = "public"
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
    },
    {
      url          = "https://microsoft.com"
      events       = ["check_run"]
      content_type = "json"
      secret       = "xxx"
      insecure_ssl = true
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
  environments = {
    "simple-env" = {
      variables = {
        "VAR" = "VAL"
      }
    }
    "other-env" = {
      secrets = {
        "SECRET" = "VAL"
      }
    }
  }
}
