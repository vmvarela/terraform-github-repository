locals {
  description                     = (var.description != null) ? var.description : (var.alias != null) ? format("aka %s", var.alias) : null
  visibility                      = (var.visibility == null && var.private != null) ? (var.private ? "private" : "public") : null
  allowed_scanning                = (var.visibility == "public" || var.advanced_security == true)
  secret_scanning                 = var.secret_scanning == true && local.allowed_scanning
  secret_scanning_push_protection = var.secret_scanning_push_protection == true && local.allowed_scanning
}
