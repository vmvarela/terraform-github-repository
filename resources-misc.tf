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

resource "github_repository_webhook" "this" {
  for_each   = var.webhooks != null ? var.webhooks : {}
  repository = github_repository.this.name
  active     = true
  configuration {
    url          = each.key
    content_type = each.value.content_type
    insecure_ssl = each.value.insecure_ssl
    secret       = each.value.secret
  }
  events = each.value.events
}

resource "github_repository_autolink_reference" "this" {
  for_each            = var.autolink_references != null ? var.autolink_references : {}
  repository          = github_repository.this.name
  key_prefix          = each.key
  target_url_template = each.value.target_url_template
  is_alphanumeric     = each.value.is_alphanumeric
}

resource "github_repository_custom_property" "this" {
  for_each       = var.properties == null ? object({}) : var.properties
  repository     = github_repository.this.name
  property_name  = each.key
  property_type  = try(var.properties_types[each.key], "string")
  property_value = flatten([each.value])
}
