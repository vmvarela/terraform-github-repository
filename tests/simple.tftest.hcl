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
  archived           = false
  archive_on_destroy = false
  enable_actions     = true
  actions_permissions = {
    allowed_actions      = "selected"
    github_owned_allowed = true
    verified_allowed     = true
  }
}

run "basic_repository_creation" {
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
