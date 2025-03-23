# repository_webhook
resource "github_repository_webhook" "this" {
  repository = var.repository
  active     = true
  configuration {
    url          = var.url
    content_type = var.content_type
    insecure_ssl = var.insecure_ssl
    secret       = var.secret
  }
  events = var.events
}
