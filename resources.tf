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
