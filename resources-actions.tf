resource "github_actions_repository_access_level" "this" {
  count        = var.actions_access_level != null ? 1 : 0
  repository   = github_repository.this.name
  access_level = var.actions_access_level
}

resource "github_actions_repository_permissions" "this" {
  count           = var.actions_permissions != null ? 1 : 0
  repository      = github_repository.this.name
  enabled         = var.actions_permissions.enabled
  allowed_actions = var.actions_permissions.allowed_actions
  dynamic "allowed_actions_config" {
    for_each = var.actions_permissions.allowed_actions == "selected" ? [1] : []
    content {
      github_owned_allowed = try(var.actions_permissions.github_owned_allowed, null)
      patterns_allowed     = try(var.actions_permissions.patterns_allowed, null)
      verified_allowed     = try(var.actions_permissions.verified_allowed, null)
    }
  }
}

resource "github_actions_secret" "this" {
  for_each        = var.secrets != null ? var.secrets : {}
  repository      = github_repository.this.name
  secret_name     = each.key
  encrypted_value = each.value.encrypted_value
  plaintext_value = each.value.plaintext_value
}

resource "github_actions_variable" "this" {
  for_each      = var.variables != null ? var.variables : {}
  repository    = github_repository.this.name
  variable_name = each.key
  value         = each.value
}

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

resource "github_actions_environment_secret" "this" {
  for_each = var.environments == null ? {} : {
    for i in flatten([
      for environment in keys(var.environments) : [
        for secret in keys(var.environments[environment].secrets) : {
          environment     = environment
          secret_name     = secret
          encrypted_value = var.environments[environment].secrets[secret].encrypted_value
          plaintext_value = var.environments[environment].secrets[secret].plaintext_value
        }
      ] if var.environments[environment].secrets != null
    ])
    : format("%s:%s", i.environment, i.secret_name) => i
  }
  repository      = github_repository.this.name
  environment     = github_repository_environment.this[each.value.environment].environment
  secret_name     = each.value.secret_name
  encrypted_value = each.value.encrypted_value
  plaintext_value = each.value.plaintext_value
}

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
