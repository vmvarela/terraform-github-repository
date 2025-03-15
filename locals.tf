locals {
  description = (var.description != null) ? var.description : (var.alias != null) ? format("aka %s", var.alias) : null
}
