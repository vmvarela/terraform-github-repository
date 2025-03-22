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
  archived           = false
  archive_on_destroy = false
  enable_actions     = true
  actions_permissions = {
    allowed_actions      = "selected"
    github_owned_allowed = true
    verified_allowed     = true
  }
}
