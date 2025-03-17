resource "github_repository" "this" {
  name                                    = var.name
  description                             = var.description
  homepage_url                            = var.homepage_url
  private                                 = var.private
  visibility                              = local.visibility
  has_issues                              = var.has_issues
  has_discussions                         = var.has_discussions
  has_projects                            = var.has_projects
  has_wiki                                = var.has_wiki
  is_template                             = var.is_template
  allow_merge_commit                      = var.allow_merge_commit
  allow_squash_merge                      = var.allow_squash_merge
  allow_rebase_merge                      = var.allow_rebase_merge
  allow_auto_merge                        = var.allow_auto_merge
  squash_merge_commit_title               = var.squash_merge_commit_title
  squash_merge_commit_message             = var.squash_merge_commit_message
  merge_commit_title                      = var.merge_commit_title
  merge_commit_message                    = var.merge_commit_message
  delete_branch_on_merge                  = var.delete_branch_on_merge
  web_commit_signoff_required             = var.web_commit_signoff_required
  auto_init                               = var.auto_init != null || var.default_branch != null
  gitignore_template                      = var.gitignore_template
  license_template                        = var.license_template
  archived                                = var.archived
  archive_on_destroy                      = var.archive_on_destroy
  topics                                  = var.topics
  vulnerability_alerts                    = var.vulnerability_alerts
  ignore_vulnerability_alerts_during_read = var.ignore_vulnerability_alerts_during_read
  allow_update_branch                     = var.allow_update_branch

  dynamic "pages" {
    for_each = var.pages != null ? [1] : []
    content {
      dynamic "source" {
        for_each = var.pages.source_branch != null ? [1] : []
        content {
          branch = var.pages.source_branch
          path   = var.pages.source_path
        }
      }
      build_type = var.pages.build_type
      cname      = var.pages.cname
    }
  }

  dynamic "security_and_analysis" {
    for_each = (var.advanced_security != null || var.secret_scanning != null || var.secret_scanning_push_protection != null) ? [1] : []
    content {
      dynamic "advanced_security" {
        for_each = var.advanced_security ? [1] : []
        content {
          status = var.advanced_security ? "enabled" : "disabled"
        }
      }
      dynamic "secret_scanning" {
        for_each = local.secret_scanning == null ? [] : [1]
        content {
          status = local.secret_scanning ? "enabled" : "disabled"
        }
      }
      dynamic "secret_scanning_push_protection" {
        for_each = local.secret_scanning_push_protection ? [1] : []
        content {
          status = local.secret_scanning_push_protection ? "enabled" : "disabled"
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

resource "github_branch_default" "this" {
  count      = var.default_branch != null ? 1 : 0
  repository = github_repository.this.name
  branch     = var.default_branch
}

resource "github_branch" "this" {
  for_each   = var.branches == null ? {} : var.branches
  repository = github_repository.this.name
  branch     = each.key
  # If each.value does not start with "sha:", set source_branch to each.value, otherwise set it to null
  source_branch = !try(startswith(each.value, "sha:"), false) ? each.value : null
  source_sha    = try(startswith(each.value, "sha:"), false) ? substr(each.value, 4, length(each.value) - 4) : null
}

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
