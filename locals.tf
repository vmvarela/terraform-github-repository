locals {
  alias = coalesce(var.alias, var.name)

  visibility = (var.visibility == null && var.private != null) ? (var.private ? "private" : "public") : var.visibility

  allowed_scanning = (var.visibility == "public" || var.advanced_security == true)

  secret_scanning                 = var.secret_scanning == true && local.allowed_scanning
  secret_scanning_push_protection = var.secret_scanning_push_protection == true && local.allowed_scanning

  repository_roles = {
    "maintain" = 2
    "write"    = 4
    "admin"    = 5
  }

  properties = var.properties == null ? {} : { for i in [
    for n, a in var.properties : {
      property = n
      type     = try(var.properties_types[n], "string")
      value    = flatten([a])
    }
    ] : i.property => i
  }
}
