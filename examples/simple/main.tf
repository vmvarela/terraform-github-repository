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
}
