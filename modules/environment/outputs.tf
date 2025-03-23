#
output "environment" {
  description = "Created environment"
  value       = github_repository_environment.this
}
