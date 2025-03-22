
module "webhook" {
  for_each     = var.webhooks != null ? { for w in var.webhooks : sha1(w.url) => w } : {}
  source       = "./modules/webhook"
  repository   = github_repository.this.name
  url          = each.value.url
  events       = each.value.events
  content_type = each.value.content_type
  insecure_ssl = try(each.value.insecure_ssl, null)
  secret       = try(each.value.secret, null)
}
