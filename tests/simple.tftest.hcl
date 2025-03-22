provider "github" {}

variables {
  name           = "tftest-repository-simple"
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
