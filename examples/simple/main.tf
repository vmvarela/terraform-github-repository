provider "github" {
}

module "repo" {
  source             = "../.."
  name               = "test-repo-simple"
  visibility         = "private"
  default_branch     = "main"
  template           = "vmvarela/template"
  archive_on_destroy = true
}
