
module "file" {
  for_each       = var.files != null ? { for f in var.files : sha1(format("%s:%s", try(f.branch, "_default_"), f.file)) => f } : {}
  source         = "./modules/file"
  repository     = github_repository.this.name
  file           = each.value.file
  content        = try(each.value.content, null)
  from_file      = try(each.value.from_file, null)
  branch         = try(each.value.branch, null)
  commit_author  = try(each.value.commit_author, null)
  commit_email   = try(each.value.commit_email, null)
  commit_message = try(each.value.commit_message, null)
}

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
