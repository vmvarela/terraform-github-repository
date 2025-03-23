module "environment" {
  for_each               = var.environments
  source                 = "./modules/environment"
  repository             = github_repository.this.name
  environment            = each.key
  wait_timer             = try(each.value.wait_timer, null)
  can_admins_bypass      = try(each.value.can_admins_bypass, null)
  prevent_self_review    = try(each.value.prevent_self_review, null)
  reviewers_teams        = try(each.value.reviewers_teams, null)
  reviewers_users        = try(each.value.reviewers_users, null)
  protected_branches     = try(each.value.protected_branches, null)
  custom_branch_policies = try(each.value.custom_branch_policies, null)
  secrets                = try(each.value.secrets, null)
  secrets_encrypted      = try(each.value.secrets_encrypted, null)
  variables              = try(each.value.variables, null)
}

module "file" {
  for_each       = { for f in var.files : sha1(format("%s:%s", try(f.branch, "_default_"), f.file)) => f }
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
  for_each     = { for w in var.webhooks : sha1(try(w.url, "_default_")) => w }
  source       = "./modules/webhook"
  repository   = github_repository.this.name
  url          = each.value.url
  events       = try(each.value.events, [])
  content_type = try(each.value.content_type, "form")
  insecure_ssl = try(each.value.insecure_ssl, false)
  secret       = try(each.value.secret, null)
}
