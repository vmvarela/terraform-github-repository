# actions_environment_secret (plaintext)
resource "github_actions_environment_secret" "plaintext" {
  for_each = var.environments == null ? {} : {
    for i in flatten([
      for environment in keys(var.environments) : [
        for secret in keys(var.environments[environment].secrets) : {
          environment  = environment
          secret_name  = secret
          secret_value = var.environments[environment].secrets[secret]
        }
      ] if var.environments[environment].secrets != null
    ])
    : format("%s:%s", i.environment, i.secret_name) => i
  }
  repository      = github_repository.this.name
  environment     = github_repository_environment.this[each.value.environment].environment
  secret_name     = each.value.secret_name
  plaintext_value = each.value.secret_value
}

# actions_environment_secret (encrypted)
resource "github_actions_environment_secret" "encrypted" {
  for_each = var.environments == null ? {} : {
    for i in flatten([
      for environment in keys(var.environments) : [
        for secret in keys(var.environments[environment].secrets_encrypted) : {
          environment  = environment
          secret_name  = secret
          secret_value = var.environments[environment].secrets_encrypted[secret]
        }
      ] if var.environments[environment].secrets != null
    ])
    : format("%s:%s", i.environment, i.secret_name) => i
  }
  repository      = github_repository.this.name
  environment     = github_repository_environment.this[each.value.environment].environment
  secret_name     = each.value.secret_name
  encrypted_value = each.value.secret_value
}

# actions_environment_variable
resource "github_actions_environment_variable" "this" {
  for_each = var.environments == null ? {} : {
    for i in flatten([
      for environment in keys(var.environments) : [
        for variable in keys(var.environments[environment].variables) : {
          environment   = environment
          variable_name = variable
          value         = var.environments[environment].variables[variable]
        }
      ] if var.environments[environment].variables != null
    ])
    : format("%s:%s", i.environment, i.variable_name) => i
  }
  repository    = github_repository.this.name
  environment   = github_repository_environment.this[each.value.environment].environment
  variable_name = each.value.variable_name
  value         = each.value.value
}

# actions_repository_access_level
resource "github_actions_repository_access_level" "this" {
  count        = var.actions_access_level != null ? 1 : 0
  repository   = github_repository.this.name
  access_level = var.actions_access_level
}

# actions_repository_permissions
resource "github_actions_repository_permissions" "this" {
  count           = (var.enable_actions != null || try(var.actions_allowed_policy, null) != null) ? 1 : 0
  repository      = github_repository.this.name
  enabled         = var.enable_actions
  allowed_actions = var.enable_actions == false ? null : try(var.actions_allowed_policy, "all")
  dynamic "allowed_actions_config" {
    for_each = (var.enable_actions == false ? null : var.actions_allowed_policy) == "selected" ? [1] : []
    content {
      github_owned_allowed = var.actions_allowed_github
      patterns_allowed     = var.actions_allowed_patterns
      verified_allowed     = var.actions_allowed_verified
    }
  }
}

# actions_secret (plaintext)
resource "github_actions_secret" "plaintext" {
  for_each        = var.secrets != null ? var.secrets : {}
  repository      = github_repository.this.name
  secret_name     = each.key
  plaintext_value = each.value
}

# actions_secret (encrypted)
resource "github_actions_secret" "encrypted" {
  for_each        = var.secrets_encrypted != null ? var.secrets_encrypted : {}
  repository      = github_repository.this.name
  secret_name     = each.key
  encrypted_value = each.value
}

# actions_variable
resource "github_actions_variable" "this" {
  for_each      = var.variables != null ? var.variables : {}
  repository    = github_repository.this.name
  variable_name = each.key
  value         = each.value
}

# branch
resource "github_branch" "this" {
  for_each   = var.branches == null ? {} : var.branches
  repository = github_repository.this.name
  branch     = each.key
  # If each.value does not start with "sha:", set source_branch to each.value, otherwise set it to null
  source_branch = !try(startswith(each.value, "sha:"), false) ? each.value : null
  source_sha    = try(startswith(each.value, "sha:"), false) ? substr(each.value, 4, length(each.value) - 4) : null
}

# branch_default
resource "github_branch_default" "this" {
  count      = var.default_branch != null ? 1 : 0
  repository = github_repository.this.name
  branch     = var.default_branch
}

# dependabot_secret (plaintext)
resource "github_dependabot_secret" "plaintext" {
  for_each        = var.dependabot_secrets != null ? var.dependabot_secrets : (var.dependabot_copy_secrets ? var.secrets : {})
  repository      = github_repository.this.name
  secret_name     = each.key
  plaintext_value = each.value
}

# dependabot_secret (encrypted)
resource "github_dependabot_secret" "encrypted" {
  for_each        = var.dependabot_secrets_encrypted != null ? var.dependabot_secrets_encrypted : (var.dependabot_copy_secrets ? var.secrets_encrypted : {})
  repository      = github_repository.this.name
  secret_name     = each.key
  encrypted_value = each.value
}

# issue_labels
resource "github_issue_labels" "this" {
  count      = var.issue_labels != null ? 1 : 0
  repository = github_repository.this.name

  dynamic "label" {
    for_each = var.issue_labels
    content {
      name        = label.key
      color       = label.value.color
      description = label.value.description
    }
  }
}

# repository
resource "github_repository" "this" {
  name                        = var.name
  description                 = var.description
  homepage_url                = var.homepage
  private                     = var.private
  visibility                  = local.visibility
  has_issues                  = var.has_issues
  has_downloads               = var.has_downloads
  has_projects                = var.has_projects
  has_wiki                    = var.has_wiki
  is_template                 = var.is_template
  allow_merge_commit          = var.allow_merge_commit
  allow_squash_merge          = var.allow_squash_merge
  allow_rebase_merge          = var.allow_rebase_merge
  allow_auto_merge            = var.allow_auto_merge
  squash_merge_commit_title   = var.squash_merge_commit_title
  squash_merge_commit_message = var.squash_merge_commit_message
  merge_commit_title          = var.merge_commit_title
  merge_commit_message        = var.merge_commit_message
  delete_branch_on_merge      = var.delete_branch_on_merge
  web_commit_signoff_required = var.web_commit_signoff_required
  auto_init                   = var.auto_init != null || var.default_branch != null
  gitignore_template          = var.gitignore_template
  license_template            = var.license_template
  archived                    = var.archived
  archive_on_destroy          = var.archive_on_destroy
  topics                      = var.topics
  vulnerability_alerts        = var.enable_vulnerability_alerts
  allow_update_branch         = var.allow_update_branch

  dynamic "pages" {
    for_each = var.pages_build_type != null ? [1] : []
    content {
      dynamic "source" {
        for_each = var.pages_source_branch != null ? [1] : []
        content {
          branch = var.pages_source_branch
          path   = var.pages_source_path
        }
      }
      build_type = var.pages_build_type
      cname      = var.pages_cname
    }
  }

  dynamic "security_and_analysis" {
    for_each = (var.enable_advanced_security != null || var.enable_secret_scanning != null || var.enable_secret_scanning_push_protection != null) ? [1] : []
    content {
      dynamic "advanced_security" {
        for_each = var.enable_advanced_security ? [1] : []
        content {
          status = var.enable_advanced_security ? "enabled" : "disabled"
        }
      }
      dynamic "secret_scanning" {
        for_each = local.enable_secret_scanning == null ? [] : [1]
        content {
          status = local.enable_secret_scanning ? "enabled" : "disabled"
        }
      }
      dynamic "secret_scanning_push_protection" {
        for_each = local.enable_secret_scanning_push_protection ? [1] : []
        content {
          status = local.enable_secret_scanning_push_protection ? "enabled" : "disabled"
        }
      }
    }
  }

  dynamic "template" {
    for_each = var.template == null ? [] : [1]
    content {
      owner                = try(element(split("/", var.template), 0), null)
      repository           = try(element(split("/", var.template), 1), null)
      include_all_branches = var.template_include_all_branches
    }
  }
}

# repository_autolink_reference
resource "github_repository_autolink_reference" "this" {
  for_each            = var.autolink_references != null ? var.autolink_references : {}
  repository          = github_repository.this.name
  key_prefix          = each.key
  target_url_template = each.value.target_url_template
  is_alphanumeric     = each.value.is_alphanumeric
}

# repository_collaborators
resource "github_repository_collaborators" "this" {
  count      = (var.teams != null || var.users != null) ? 1 : 0
  repository = github_repository.this.name
  dynamic "user" {
    for_each = try(var.users, null) != null ? var.users : {}
    content {
      permission = user.value
      username   = user.key
    }
  }
  dynamic "team" {
    for_each = try(var.teams, null) != null ? var.teams : {}
    content {
      permission = team.value
      team_id    = team.key
    }
  }
}

# repository_custom_property
resource "github_repository_custom_property" "this" {
  for_each       = local.custom_properties
  repository     = github_repository.this.name
  property_name  = each.key
  property_type  = each.value.type
  property_value = each.value.value
}

# repository_dependabot_security_updates
resource "github_repository_dependabot_security_updates" "this" {
  count      = var.enable_dependabot_security_updates != null ? 1 : 0
  repository = github_repository.this.name
  enabled    = var.enable_dependabot_security_updates
}

# repository_deploy_key
resource "github_repository_deploy_key" "this" {
  for_each   = var.deploy_keys != null ? var.deploy_keys : {}
  repository = github_repository.this.name
  title      = each.key
  key        = each.value.key != null ? each.value.key : tls_private_key.this[each.key].public_key_openssh
  read_only  = each.value.read_only
}

# repository_environment
resource "github_repository_environment" "this" {
  for_each            = var.environments != null ? var.environments : {}
  repository          = github_repository.this.name
  environment         = each.key
  wait_timer          = each.value.wait_timer
  can_admins_bypass   = each.value.can_admins_bypass
  prevent_self_review = each.value.prevent_self_review
  dynamic "reviewers" {
    for_each = (each.value.reviewers_teams != null || each.value.reviewers_users != null) ? [1] : []
    content {
      teams = each.value.reviewers_teams
      users = each.value.reviewers_users
    }
  }
  dynamic "deployment_branch_policy" {
    for_each = (each.value.protected_branches != null || each.value.custom_branch_policies != null) ? [1] : []
    content {
      protected_branches     = each.value.custom_branch_policies == null ? each.value.protected_branches : false
      custom_branch_policies = try(length(each.value.custom_branch_policies), 0) > 0
    }
  }
}

# repository_environment_deployment_policy
resource "github_repository_environment_deployment_policy" "this" {
  for_each = var.environments == null ? {} : {
    for i in flatten([
      for environment in keys(var.environments) : [
        for branch_pattern in var.environments[environment].custom_branch_policies : {
          environment    = environment
          branch_pattern = branch_pattern
        }
      ] if var.environments[environment].custom_branch_policies != null
    ])
    : format("%s:%s", i.environment, i.branch_pattern) => i
  }
  repository     = github_repository.this.name
  environment    = github_repository_environment.this[each.value.environment].environment
  branch_pattern = each.value.branch_pattern
}

# repository_file
resource "github_repository_file" "this" {
  for_each       = var.files != null ? var.files : {}
  repository     = github_repository.this.name
  file           = each.key
  content        = each.value.from_file != null ? file(each.value.from_file) : each.value.content
  branch         = each.value.branch
  commit_author  = each.value.commit_author
  commit_email   = each.value.commit_email
  commit_message = each.value.commit_message
}

# repository_ruleset
resource "github_repository_ruleset" "this" {
  for_each    = var.rulesets != null ? var.rulesets : {}
  repository  = github_repository.this.name
  name        = each.key
  enforcement = each.value.enforcement
  target      = each.value.target

  dynamic "conditions" {
    for_each = (length(each.value.include) + length(each.value.exclude) > 0) ? [1] : []
    content {
      ref_name {
        include = [for p in each.value.include :
          substr(p, 0, 1) == "~" ? p : format("refs/%s/%s", each.value.target == "branch" ? "heads" : "tags", p)
        ]
        exclude = [for p in each.value.exclude :
          substr(p, 0, 1) == "~" ? p : format("refs/%s/%s", each.value.target == "branch" ? "heads" : "tags", p)
        ]
      }
    }
  }

  dynamic "bypass_actors" {
    for_each = (each.value.bypass_roles != null) ? each.value.bypass_roles : []
    content {
      actor_type  = "RepositoryRole"
      actor_id    = lookup(local.repository_roles, bypass_actors.value, null)
      bypass_mode = each.value.bypass_mode
    }
  }
  dynamic "bypass_actors" {
    for_each = (each.value.bypass_teams != null) ? each.value.bypass_teams : []
    content {
      actor_type  = "Team"
      actor_id    = bypass_actors.value
      bypass_mode = each.value.bypass_mode
    }
  }
  dynamic "bypass_actors" {
    for_each = (each.value.bypass_integration != null) ? each.value.bypass_integration : []
    content {
      actor_type  = "Integration"
      actor_id    = bypass_actors.value
      bypass_mode = each.value.bypass_mode
    }
  }
  dynamic "bypass_actors" {
    for_each = each.value.bypass_organization_admin == true ? [1] : []
    content {
      actor_type  = "OrganizationAdmin"
      actor_id    = 0 # admin
      bypass_mode = each.value.bypass_mode
    }
  }

  rules {
    dynamic "branch_name_pattern" {
      for_each = try(each.value.regex_branch_name, null) != null ? [1] : []
      content {
        operator = "regex"
        pattern  = each.value.regex_branch_name
      }
    }
    dynamic "tag_name_pattern" {
      for_each = try(each.value.regex_tag_name, null) != null ? [1] : []
      content {
        operator = "regex"
        pattern  = each.value.regex_tag_name
      }
    }
    dynamic "commit_author_email_pattern" {
      for_each = try(each.value.regex_commit_author_email, null) != null ? [1] : []
      content {
        operator = "regex"
        pattern  = each.value.each.value.regex_commit_author_email
      }
    }
    dynamic "commit_message_pattern" {
      for_each = try(each.value.regex_commit_message, null) != null ? [1] : []
      content {
        operator = "regex"
        pattern  = each.value.regex_commit_message
      }
    }
    dynamic "committer_email_pattern" {
      for_each = try(each.value.regex_committer_email, null) != null ? [1] : []
      content {
        operator = "regex"
        pattern  = each.value.regex_committer_email
      }
    }

    creation         = each.value.forbidden_creation
    deletion         = each.value.forbidden_deletion
    update           = each.value.forbidden_update
    non_fast_forward = each.value.forbidden_fast_forward

    dynamic "pull_request" {
      for_each = try(each.value.rules.pull_request, null) != null ? [1] : []
      content {
        dismiss_stale_reviews_on_push     = each.value.dismiss_pr_stale_reviews_on_push
        require_code_owner_review         = each.value.required_pr_code_owner_review
        require_last_push_approval        = each.value.required_pr_last_push_approval
        required_approving_review_count   = each.value.required_pr_approving_review_count
        required_review_thread_resolution = each.value.required_pr_review_thread_resolution
      }
    }
    dynamic "required_deployments" {
      for_each = (each.value.required_deployment_environments != null) ? [1] : []
      content {
        required_deployment_environments = each.value.required_deployment_environments
      }
    }
    required_linear_history = each.value.required_linear_history
    required_signatures     = each.value.required_signatures
    dynamic "required_status_checks" {
      for_each = (each.value.required_checks != null) ? [1] : []
      content {
        dynamic "required_check" {
          for_each = each.value.rules.required_status_checks
          content {
            context = required_check.value
          }
        }
      }
    }
  }
}
