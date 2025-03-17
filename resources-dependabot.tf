resource "github_dependabot_secret" "this" {
  for_each        = var.dependabot_secrets != null ? var.secrets : {}
  repository      = github_repository.this.name
  secret_name     = each.key
  encrypted_value = each.value.encrypted_value
  plaintext_value = each.value.plaintext_value
}

resource "github_repository_dependabot_security_updates" "this" {
  count      = var.dependabot_security_updates != null ? 1 : 0
  repository = github_repository.this.name
  enabled    = var.dependabot_security_updates
}
