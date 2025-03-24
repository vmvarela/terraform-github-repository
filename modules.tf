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

module "ruleset" {
  for_each                             = var.rulesets
  source                               = "./modules/ruleset"
  repository                           = github_repository.this.name
  name                                 = each.key
  enforcement                          = try(each.value.enforcement, "active")
  target                               = try(each.value.target, "branch")
  include                              = try(each.value.include, [])
  exclude                              = try(each.value.exclude, [])
  bypass_mode                          = try(each.value.bypass_mode, "always")
  bypass_organization_admin            = try(each.value.bypass_organization_admin, null)
  bypass_roles                         = try(each.value.bypass_roles, [])
  bypass_teams                         = try(each.value.bypass_teams, [])
  bypass_integration                   = try(each.value.bypass_integration, [])
  regex_target                         = try(each.value.regex_target, null)
  regex_commit_author_email            = try(each.value.regex_commit_author_email, null)
  regex_committer_email                = try(each.value.regex_committer_email, null)
  regex_commit_message                 = try(each.value.regex_commit_message, null)
  forbidden_creation                   = try(each.value.forbidden_creation, null)
  forbidden_deletion                   = try(each.value.forbidden_deletion, null)
  forbidden_update                     = try(each.value.forbidden_update, null)
  forbidden_fast_forward               = try(each.value.forbidden_fast_forward, null)
  dismiss_pr_stale_reviews_on_push     = try(each.value.dismiss_pr_stale_reviews_on_push, null)
  required_pr_code_owner_review        = try(each.value.required_pr_code_owner_review, null)
  required_pr_last_push_approval       = try(each.value.required_pr_last_push_approval, null)
  required_pr_approving_review_count   = try(each.value.required_pr_approving_review_count, null)
  required_pr_review_thread_resolution = try(each.value.required_pr_review_thread_resolution, null)
  required_deployment_environments     = try(each.value.required_deployment_environments, [])
  required_linear_history              = try(each.value.required_linear_history, null)
  required_signatures                  = try(each.value.required_signatures, null)
  required_checks                      = try(each.value.required_checks, [])
  required_code_scanning               = try(each.value.required_code_scanning, {})
  depends_on                           = [module.environment]
}
