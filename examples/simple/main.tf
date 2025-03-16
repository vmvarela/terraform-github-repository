module "repo" {
  source             = "../.."
  name               = "test-repo-simple"
  visibility         = "private"
  default_branch     = "master"
  template           = "vmvarela/template"
  archive_on_destroy = true
}
