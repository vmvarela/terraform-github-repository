# actions_repository_access_level
resource "github_actions_repository_access_level" "this" {
  count        = var.actions_access_level != null ? 1 : 0
  repository   = github_repository.this.name
  access_level = var.actions_access_level
}

# actions_repository_permissions
resource "github_actions_repository_permissions" "this" {
  count           = (var.enable_actions != null || var.actions_allowed_policy != null) ? 1 : 0
  repository      = github_repository.this.name
  enabled         = var.enable_actions
  allowed_actions = var.enable_actions == false ? null : var.actions_allowed_policy
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
  for_each        = var.secrets
  repository      = github_repository.this.name
  secret_name     = each.key
  plaintext_value = each.value
}

# actions_secret (encrypted)
resource "github_actions_secret" "encrypted" {
  for_each        = var.secrets_encrypted
  repository      = github_repository.this.name
  secret_name     = each.key
  encrypted_value = each.value
}

# actions_variable
resource "github_actions_variable" "this" {
  for_each      = var.variables
  repository    = github_repository.this.name
  variable_name = each.key
  value         = each.value
}

# branch
resource "github_branch" "this" {
  for_each   = var.branches
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
  for_each        = var.dependabot_secrets != null ? var.dependabot_secrets : (var.dependabot_copy_secrets ? var.secrets : null)
  repository      = github_repository.this.name
  secret_name     = each.key
  plaintext_value = each.value
}

# dependabot_secret (encrypted)
resource "github_dependabot_secret" "encrypted" {
  for_each        = var.dependabot_secrets_encrypted != null ? var.dependabot_secrets_encrypted : (var.dependabot_copy_secrets ? var.secrets_encrypted : null)
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
      color       = var.issue_labels_colors == null ? substr(sha256(label.key), 0, 6) : lookup(var.issue_labels_colors, label.key, substr(sha256(label.key), 0, 6))
      description = label.value
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
  for_each            = var.autolink_references
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
    for_each = var.users
    content {
      permission = user.value
      username   = user.key
    }
  }
  dynamic "team" {
    for_each = var.teams
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
  for_each   = var.deploy_keys
  repository = github_repository.this.name
  title      = each.key
  key        = each.value.key != null ? each.value.key : tls_private_key.this[each.key].public_key_openssh
  read_only  = each.value.read_only
}
