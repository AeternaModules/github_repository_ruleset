variable "repository_rulesets" {
  description = <<EOT
Map of repository_rulesets, attributes below
Required:
    - enforcement
    - name
    - repository
    - target
    - rules (block):
        - branch_name_pattern (optional, block):
            - name (optional)
            - negate (optional)
            - operator (required)
            - pattern (required)
        - commit_author_email_pattern (optional, block):
            - name (optional)
            - negate (optional)
            - operator (required)
            - pattern (required)
        - commit_message_pattern (optional, block):
            - name (optional)
            - negate (optional)
            - operator (required)
            - pattern (required)
        - committer_email_pattern (optional, block):
            - name (optional)
            - negate (optional)
            - operator (required)
            - pattern (required)
        - copilot_code_review (optional, block):
            - review_draft_pull_requests (optional)
            - review_on_push (optional)
        - creation (optional)
        - deletion (optional)
        - file_extension_restriction (optional, block):
            - restricted_file_extensions (required)
        - file_path_restriction (optional, block):
            - restricted_file_paths (required)
        - max_file_path_length (optional, block):
            - max_file_path_length (required)
        - max_file_size (optional, block):
            - max_file_size (required)
        - merge_queue (optional, block):
            - check_response_timeout_minutes (optional)
            - grouping_strategy (optional)
            - max_entries_to_build (optional)
            - max_entries_to_merge (optional)
            - merge_method (optional)
            - min_entries_to_merge (optional)
            - min_entries_to_merge_wait_minutes (optional)
        - non_fast_forward (optional)
        - pull_request (optional, block):
            - allowed_merge_methods (optional)
            - dismiss_stale_reviews_on_push (optional)
            - require_code_owner_review (optional)
            - require_last_push_approval (optional)
            - required_approving_review_count (optional)
            - required_review_thread_resolution (optional)
            - required_reviewers (optional, block):
                - file_patterns (required)
                - minimum_approvals (required)
                - reviewer (required, block):
                    - id (required)
                    - type (required)
        - required_code_scanning (optional, block):
            - required_code_scanning_tool (required, block):
                - alerts_threshold (required)
                - security_alerts_threshold (required)
                - tool (required)
        - required_deployments (optional, block):
            - required_deployment_environments (required)
        - required_linear_history (optional)
        - required_signatures (optional)
        - required_status_checks (optional, block):
            - do_not_enforce_on_create (optional)
            - required_check (required, block):
                - context (required)
                - integration_id (optional)
            - strict_required_status_checks_policy (optional)
        - tag_name_pattern (optional, block):
            - name (optional)
            - negate (optional)
            - operator (required)
            - pattern (required)
        - update (optional)
        - update_allows_fetch_and_merge (optional)
Optional:
    - bypass_actors (block):
        - actor_id (optional)
        - actor_type (required)
        - bypass_mode (required)
    - conditions (block):
        - ref_name (required, block):
            - exclude (required)
            - include (required)
EOT

  type = map(object({
    enforcement = string
    name        = string
    repository  = string
    target      = string
    rules = object({
      branch_name_pattern = optional(object({
        name     = optional(string)
        negate   = optional(bool)
        operator = string
        pattern  = string
      }))
      commit_author_email_pattern = optional(object({
        name     = optional(string)
        negate   = optional(bool)
        operator = string
        pattern  = string
      }))
      commit_message_pattern = optional(object({
        name     = optional(string)
        negate   = optional(bool)
        operator = string
        pattern  = string
      }))
      committer_email_pattern = optional(object({
        name     = optional(string)
        negate   = optional(bool)
        operator = string
        pattern  = string
      }))
      copilot_code_review = optional(object({
        review_draft_pull_requests = optional(bool)
        review_on_push             = optional(bool)
      }))
      creation = optional(bool)
      deletion = optional(bool)
      file_extension_restriction = optional(object({
        restricted_file_extensions = set(string)
      }))
      file_path_restriction = optional(object({
        restricted_file_paths = list(string)
      }))
      max_file_path_length = optional(object({
        max_file_path_length = number
      }))
      max_file_size = optional(object({
        max_file_size = number
      }))
      merge_queue = optional(object({
        check_response_timeout_minutes    = optional(number)
        grouping_strategy                 = optional(string)
        max_entries_to_build              = optional(number)
        max_entries_to_merge              = optional(number)
        merge_method                      = optional(string)
        min_entries_to_merge              = optional(number)
        min_entries_to_merge_wait_minutes = optional(number)
      }))
      non_fast_forward = optional(bool)
      pull_request = optional(object({
        allowed_merge_methods             = optional(list(string))
        dismiss_stale_reviews_on_push     = optional(bool)
        require_code_owner_review         = optional(bool)
        require_last_push_approval        = optional(bool)
        required_approving_review_count   = optional(number)
        required_review_thread_resolution = optional(bool)
        required_reviewers = optional(list(object({
          file_patterns     = list(string)
          minimum_approvals = number
          reviewer = object({
            id   = number
            type = string
          })
        })))
      }))
      required_code_scanning = optional(object({
        required_code_scanning_tool = list(object({
          alerts_threshold          = string
          security_alerts_threshold = string
          tool                      = string
        }))
      }))
      required_deployments = optional(object({
        required_deployment_environments = list(string)
      }))
      required_linear_history = optional(bool)
      required_signatures     = optional(bool)
      required_status_checks = optional(object({
        do_not_enforce_on_create = optional(bool)
        required_check = list(object({
          context        = string
          integration_id = optional(number)
        }))
        strict_required_status_checks_policy = optional(bool)
      }))
      tag_name_pattern = optional(object({
        name     = optional(string)
        negate   = optional(bool)
        operator = string
        pattern  = string
      }))
      update                        = optional(bool)
      update_allows_fetch_and_merge = optional(bool)
    })
    bypass_actors = optional(list(object({
      actor_id    = optional(number)
      actor_type  = string
      bypass_mode = string
    })))
    conditions = optional(object({
      ref_name = object({
        exclude = list(string)
        include = list(string)
      })
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.required_code_scanning == null || (length(v.rules.required_code_scanning.required_code_scanning_tool) >= 1)
      )
    ])
    error_message = "Each required_code_scanning_tool list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.required_status_checks == null || (length(v.rules.required_status_checks.required_check) >= 1)
      )
    ])
    error_message = "Each required_check list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        length(v.name) >= 1 && length(v.name) <= 100
      )
    ])
    error_message = "must be between 1 and 100 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        can(regex("^[-a-zA-Z0-9_.]{1,100}$", v.repository))
      )
    ])
    error_message = "must include only alphanumeric characters, underscores or hyphens and consist of 100 characters or less"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        contains(["disabled", "active", "evaluate"], v.enforcement)
      )
    ])
    error_message = "must be one of: disabled, active, evaluate"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.bypass_actors == null || alltrue([for item in v.bypass_actors : (contains(["RepositoryRole", "Team", "Integration", "OrganizationAdmin", "DeployKey", "EnterpriseOwner", "User"], item.actor_type))])
      )
    ])
    error_message = "must be one of: RepositoryRole, Team, Integration, OrganizationAdmin, DeployKey, EnterpriseOwner, User"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.bypass_actors == null || alltrue([for item in v.bypass_actors : (contains(["always", "pull_request", "exempt"], item.bypass_mode))])
      )
    ])
    error_message = "must be one of: always, pull_request, exempt"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.pull_request == null || (v.rules.pull_request.allowed_merge_methods == null || (alltrue([for x in v.rules.pull_request.allowed_merge_methods : contains(["merge", "squash", "rebase"], x)])))
      )
    ])
    error_message = "must be one of: merge, squash, rebase"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.pull_request == null || (v.rules.pull_request.required_approving_review_count == null || (v.rules.pull_request.required_approving_review_count >= 0 && v.rules.pull_request.required_approving_review_count <= 10))
      )
    ])
    error_message = "must be between 0 and 10"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.pull_request == null || (v.rules.pull_request.required_reviewers == null || alltrue([for item in v.rules.pull_request.required_reviewers : (contains(["Team"], item.reviewer.type))]))
      )
    ])
    error_message = "must be one of: Team"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.merge_queue == null || (v.rules.merge_queue.check_response_timeout_minutes == null || (v.rules.merge_queue.check_response_timeout_minutes >= 0 && v.rules.merge_queue.check_response_timeout_minutes <= 360))
      )
    ])
    error_message = "must be between 0 and 360"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.merge_queue == null || (v.rules.merge_queue.grouping_strategy == null || (contains(["ALLGREEN", "HEADGREEN"], v.rules.merge_queue.grouping_strategy)))
      )
    ])
    error_message = "must be one of: ALLGREEN, HEADGREEN"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.merge_queue == null || (v.rules.merge_queue.max_entries_to_build == null || (v.rules.merge_queue.max_entries_to_build >= 0 && v.rules.merge_queue.max_entries_to_build <= 100))
      )
    ])
    error_message = "must be between 0 and 100"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.merge_queue == null || (v.rules.merge_queue.max_entries_to_merge == null || (v.rules.merge_queue.max_entries_to_merge >= 0 && v.rules.merge_queue.max_entries_to_merge <= 100))
      )
    ])
    error_message = "must be between 0 and 100"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.merge_queue == null || (v.rules.merge_queue.merge_method == null || (contains(["MERGE", "SQUASH", "REBASE"], v.rules.merge_queue.merge_method)))
      )
    ])
    error_message = "must be one of: MERGE, SQUASH, REBASE"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.merge_queue == null || (v.rules.merge_queue.min_entries_to_merge == null || (v.rules.merge_queue.min_entries_to_merge >= 0 && v.rules.merge_queue.min_entries_to_merge <= 100))
      )
    ])
    error_message = "must be between 0 and 100"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.merge_queue == null || (v.rules.merge_queue.min_entries_to_merge_wait_minutes == null || (v.rules.merge_queue.min_entries_to_merge_wait_minutes >= 0 && v.rules.merge_queue.min_entries_to_merge_wait_minutes <= 360))
      )
    ])
    error_message = "must be between 0 and 360"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.required_code_scanning == null || (alltrue([for item in v.rules.required_code_scanning.required_code_scanning_tool : (contains(["none", "errors", "errors_and_warnings", "all"], item.alerts_threshold))]))
      )
    ])
    error_message = "must be one of: none, errors, errors_and_warnings, all"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.required_code_scanning == null || (alltrue([for item in v.rules.required_code_scanning.required_code_scanning_tool : (contains(["none", "critical", "high_or_higher", "medium_or_higher", "all"], item.security_alerts_threshold))]))
      )
    ])
    error_message = "must be one of: none, critical, high_or_higher, medium_or_higher, all"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.max_file_size == null || (v.rules.max_file_size.max_file_size >= 1 && v.rules.max_file_size.max_file_size <= 100)
      )
    ])
    error_message = "must be between 1 and 100"
  }
  validation {
    condition = alltrue([
      for k, v in var.repository_rulesets : (
        v.rules.max_file_path_length == null || (v.rules.max_file_path_length.max_file_path_length >= 1 && v.rules.max_file_path_length.max_file_path_length <= 32767)
      )
    ])
    error_message = "must be between 1 and 32767"
  }
  # Note: 6 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

