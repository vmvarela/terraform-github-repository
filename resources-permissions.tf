resource "github_repository_collaborators" "this" {
  count      = (var.teams != null || var.users != null) ? 1 : 0
  repository = github_repository.this.name
  dynamic "user" {
    for_each = try(var.users, null) != null ? var.users : {}
    content {
      permission = user.value
      username   = user.key
    }
  }
  dynamic "team" {
    for_each = try(var.teams, null) != null ? var.teams : {}
    content {
      permission = team.value
      team_id    = team.key
    }
  }
}

resource "github_repository_deploy_key" "this" {
  for_each   = var.deploy_keys != null ? var.deploy_keys : {}
  repository = github_repository.this.name
  title      = each.key
  key        = each.value.key != null ? each.value.key : tls_private_key.this[each.key].public_key_openssh
  read_only  = each.value.read_only
}

# auto-generated if the key is not provided
resource "tls_private_key" "this" {
  for_each = var.deploy_keys == null ? {} : {
    for name, config in var.deploy_keys : name => config if config.key == null
  }
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "null_resource" "create_subfolder" {
  count = var.deploy_keys == null ? 0 : 1
  provisioner "local-exec" {
    command = "mkdir -p ${var.deploy_keys_path}"
  }
}

resource "local_file" "private_key_file" {
  for_each = var.deploy_keys == null ? {} : {
    for name, config in var.deploy_keys : name => config if config.key == null
  }
  filename = "${var.deploy_keys_path}/${github_repository.this.name}-${each.key}.pem"
  content  = tls_private_key.this[each.key].private_key_openssh
  depends_on = [
    null_resource.create_subfolder
  ]
}
