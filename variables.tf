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
  # --- Unconfirmed validation candidates, derived from github_repository_ruleset's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: name
  #   condition: length(value) >= 1 && length(value) <= 100
  #   message:   must be between 1 and 100 characters
  # path: target
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: repository
  #   condition: can(regex("^[-a-zA-Z0-9_.]{1,100}$", value))
  #   message:   must include only alphanumeric characters, underscores or hyphens and consist of 100 characters or less
  # path: enforcement
  #   condition: contains(["disabled", "active", "evaluate"], value)
  #   message:   must be one of: disabled, active, evaluate
  # path: bypass_actors.actor_type
  #   condition: contains(["RepositoryRole", "Team", "Integration", "OrganizationAdmin", "DeployKey", "EnterpriseOwner", "User"], value)
  #   message:   must be one of: RepositoryRole, Team, Integration, OrganizationAdmin, DeployKey, EnterpriseOwner, User
  # path: bypass_actors.bypass_mode
  #   condition: contains(["always", "pull_request", "exempt"], value)
  #   message:   must be one of: always, pull_request, exempt
  # path: rules.pull_request.allowed_merge_methods[*]
  #   condition: contains(["merge", "squash", "rebase"], value)
  #   message:   must be one of: merge, squash, rebase
  # path: rules.pull_request.required_approving_review_count
  #   condition: value >= 0 && value <= 10
  #   message:   must be between 0 and 10
  # path: rules.pull_request.required_reviewers.reviewer.type
  #   condition: contains(["Team"], value)
  #   message:   must be one of: Team
  # path: rules.merge_queue.check_response_timeout_minutes
  #   condition: value >= 0 && value <= 360
  #   message:   must be between 0 and 360
  # path: rules.merge_queue.grouping_strategy
  #   condition: contains(["ALLGREEN", "HEADGREEN"], value)
  #   message:   must be one of: ALLGREEN, HEADGREEN
  # path: rules.merge_queue.max_entries_to_build
  #   condition: value >= 0 && value <= 100
  #   message:   must be between 0 and 100
  # path: rules.merge_queue.max_entries_to_merge
  #   condition: value >= 0 && value <= 100
  #   message:   must be between 0 and 100
  # path: rules.merge_queue.merge_method
  #   condition: contains(["MERGE", "SQUASH", "REBASE"], value)
  #   message:   must be one of: MERGE, SQUASH, REBASE
  # path: rules.merge_queue.min_entries_to_merge
  #   condition: value >= 0 && value <= 100
  #   message:   must be between 0 and 100
  # path: rules.merge_queue.min_entries_to_merge_wait_minutes
  #   condition: value >= 0 && value <= 360
  #   message:   must be between 0 and 360
  # path: rules.commit_message_pattern.operator
  #   source:    operatorValidation (unresolved: func operatorValidation not found in /home/dan/code/public/terraform-provider-github/github)
  # path: rules.commit_author_email_pattern.operator
  #   source:    operatorValidation (unresolved: func operatorValidation not found in /home/dan/code/public/terraform-provider-github/github)
  # path: rules.committer_email_pattern.operator
  #   source:    operatorValidation (unresolved: func operatorValidation not found in /home/dan/code/public/terraform-provider-github/github)
  # path: rules.branch_name_pattern.operator
  #   source:    operatorValidation (unresolved: func operatorValidation not found in /home/dan/code/public/terraform-provider-github/github)
  # path: rules.tag_name_pattern.operator
  #   source:    operatorValidation (unresolved: func operatorValidation not found in /home/dan/code/public/terraform-provider-github/github)
  # path: rules.required_code_scanning.required_code_scanning_tool.alerts_threshold
  #   condition: contains(["none", "errors", "errors_and_warnings", "all"], value)
  #   message:   must be one of: none, errors, errors_and_warnings, all
  # path: rules.required_code_scanning.required_code_scanning_tool.security_alerts_threshold
  #   condition: contains(["none", "critical", "high_or_higher", "medium_or_higher", "all"], value)
  #   message:   must be one of: none, critical, high_or_higher, medium_or_higher, all
  # path: rules.max_file_size.max_file_size
  #   condition: value >= 1 && value <= 100
  #   message:   must be between 1 and 100
  # path: rules.max_file_path_length.max_file_path_length
  #   condition: value >= 1 && value <= 32767
  #   message:   must be between 1 and 32767
}

