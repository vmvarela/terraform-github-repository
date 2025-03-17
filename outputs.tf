output "repository" {
  description = "Created repository"
  value       = github_repository.this
}

output "alias" {
  description = "Alias (used for renaming)"
  value       = local.alias
}
