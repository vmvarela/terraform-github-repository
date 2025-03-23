locals {
  alias = coalesce(var.alias, var.name)

  visibility = (var.visibility == null && var.private != null) ? (var.private ? "private" : "public") : var.visibility

  allowed_scanning                       = (var.visibility == "public" || var.enable_advanced_security == true)
  enable_secret_scanning                 = var.enable_secret_scanning == true && local.allowed_scanning
  enable_secret_scanning_push_protection = var.enable_secret_scanning_push_protection == true && local.allowed_scanning

  custom_properties = var.custom_properties == null ? {} : { for i in [
    for n, a in var.custom_properties : {
      property = n
      type     = try(var.custom_properties_types[n], "string")
      value    = flatten([a])
    }
    ] : i.property => i
  }
}
