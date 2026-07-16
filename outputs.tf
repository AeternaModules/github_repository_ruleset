output "repository_rulesets_id" {
  description = "Map of id values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.id if v.id != null && length(v.id) > 0 }
}
output "repository_rulesets_bypass_actors" {
  description = "Map of bypass_actors values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.bypass_actors if v.bypass_actors != null && length(v.bypass_actors) > 0 }
}
output "repository_rulesets_conditions" {
  description = "Map of conditions values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.conditions if v.conditions != null && length(v.conditions) > 0 }
}
output "repository_rulesets_enforcement" {
  description = "Map of enforcement values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.enforcement if v.enforcement != null && length(v.enforcement) > 0 }
}
output "repository_rulesets_etag" {
  description = "Map of etag values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.etag if v.etag != null && length(v.etag) > 0 }
}
output "repository_rulesets_name" {
  description = "Map of name values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.name if v.name != null && length(v.name) > 0 }
}
output "repository_rulesets_node_id" {
  description = "Map of node_id values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.node_id if v.node_id != null && length(v.node_id) > 0 }
}
output "repository_rulesets_repository" {
  description = "Map of repository values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.repository if v.repository != null && length(v.repository) > 0 }
}
output "repository_rulesets_rules" {
  description = "Map of rules values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.rules if v.rules != null && length(v.rules) > 0 }
}
output "repository_rulesets_ruleset_id" {
  description = "Map of ruleset_id values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.ruleset_id if v.ruleset_id != null }
}
output "repository_rulesets_target" {
  description = "Map of target values across all repository_rulesets, keyed the same as var.repository_rulesets"
  value       = { for k, v in github_repository_ruleset.repository_rulesets : k => v.target if v.target != null && length(v.target) > 0 }
}

