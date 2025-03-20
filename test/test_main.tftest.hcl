// test/basic_repository.tftest.hcl
mock_provider "github" {
  built_in_providers_only = true
}

variables {
  name        = "test-repo"
  description = "Test repository"
  visibility  = "private"
  has_issues  = true
  auto_init   = true
}

run "basic_repository_creation" {
  command = plan

  assert {
    condition     = github_repository.this.name == var.name
    error_message = "Repository name doesn't match input"
  }

  assert {
    condition     = github_repository.this.description == var.description
    error_message = "Repository description doesn't match input"
  }

  assert {
    condition     = github_repository.this.private == true
    error_message = "Repository should be private"
  }
}
