locals {
  alias                           = var.alias == null ? var.name : var.alias
  visibility                      = (var.visibility == null && var.private != null) ? (var.private ? "private" : "public") : var.visibility
  allowed_scanning                = (var.visibility == "public" || var.advanced_security == true)
  secret_scanning                 = var.secret_scanning == true && local.allowed_scanning
  secret_scanning_push_protection = var.secret_scanning_push_protection == true && local.allowed_scanning
  repository_roles = {
    "maintain" = 2
    "write"    = 4
    "admin"    = 5
  }
}
