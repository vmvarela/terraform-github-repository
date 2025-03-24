provider "github" {}

variables {
  name           = "tftest-repository-simple"
  visibility     = "public"
  template       = "vmvarela/template"
  rulesets = {
    "test" = {
      target  = "branch"
      include = ["~DEFAULT_BRANCH"]
      required_code_scanning = {
        "CodeQL" = "none:errors_and_warnings"
      }
    }
  }
}

run "repository_creation" {
  command = apply

  assert {
    condition     = github_repository.this.name == var.name
    error_message = "Repository name doesn't match input"
  }
}
