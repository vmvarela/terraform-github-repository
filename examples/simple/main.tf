module "repo" {
  source         = "../.."
  name           = "test-repo-simple"
  visibility     = "private"
  default_branch = "master"
  template       = "vmvarela/template"
  branches = {
    "develop" = "master"
  }
  archive_on_destroy = true
}
