output "repository_rulesets_id" {
  description = "Map of id values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.id }
}
output "repository_rulesets_bypass_actors" {
  description = "Map of bypass_actors values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.bypass_actors }
}
output "repository_rulesets_conditions" {
  description = "Map of conditions values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.conditions }
}
output "repository_rulesets_enforcement" {
  description = "Map of enforcement values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.enforcement }
}
output "repository_rulesets_etag" {
  description = "Map of etag values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.etag }
}
output "repository_rulesets_name" {
  description = "Map of name values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.name }
}
output "repository_rulesets_node_id" {
  description = "Map of node_id values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.node_id }
}
output "repository_rulesets_repository" {
  description = "Map of repository values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.repository }
}
output "repository_rulesets_rules" {
  description = "Map of rules values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.rules }
}
output "repository_rulesets_ruleset_id" {
  description = "Map of ruleset_id values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.ruleset_id }
}
output "repository_rulesets_target" {
  description = "Map of target values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.target }
}

