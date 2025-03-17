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
