provider "github" {}

variables {
  name           = "tftest-repository-simple"
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

  secrets = {
    "SECRETO" = "VALOR"
  }
  secrets_encrypted = {
    "CLAVE" = base64encode("VALOR-ENCRIPTADO")
  }
  dependabot_copy_secrets = true

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

  environments = {
    "staging" = {
      variables = {
        "var" = "val"
      }
    }
  }

  rulesets = {
    "test" = {
      target                             = "branch"
      exclude                            = ["feature/*", "hotfix/*", "release/*"]
      bypass_roles                       = ["admin", "write"]
      forbidden_creation                 = true
      required_pr_approving_review_count = 2
    },
    "test-2" = {
      target             = "tag"
      include            = ["~ALL"]
      forbidden_deletion = true
    }
  }

}

run "repository_creation" {
  command = apply

  assert {
    condition     = github_repository.this.name == var.name
    error_message = "Repository name doesn't match input"
  }

  assert {
    condition     = github_repository.this.visibility == var.visibility
    error_message = "Repository should be private"
  }
}
