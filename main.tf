resource "github_repository_ruleset" "repository_rulesets" {
  for_each = var.repository_rulesets

  enforcement = each.value.enforcement
  name        = each.value.name
  repository  = each.value.repository
  target      = each.value.target

  rules {
    dynamic "branch_name_pattern" {
      for_each = each.value.rules.branch_name_pattern != null ? [each.value.rules.branch_name_pattern] : []
      content {
        name     = branch_name_pattern.value.name
        negate   = branch_name_pattern.value.negate
        operator = branch_name_pattern.value.operator
        pattern  = branch_name_pattern.value.pattern
      }
    }
    dynamic "commit_author_email_pattern" {
      for_each = each.value.rules.commit_author_email_pattern != null ? [each.value.rules.commit_author_email_pattern] : []
      content {
        name     = commit_author_email_pattern.value.name
        negate   = commit_author_email_pattern.value.negate
        operator = commit_author_email_pattern.value.operator
        pattern  = commit_author_email_pattern.value.pattern
      }
    }
    dynamic "commit_message_pattern" {
      for_each = each.value.rules.commit_message_pattern != null ? [each.value.rules.commit_message_pattern] : []
      content {
        name     = commit_message_pattern.value.name
        negate   = commit_message_pattern.value.negate
        operator = commit_message_pattern.value.operator
        pattern  = commit_message_pattern.value.pattern
      }
    }
    dynamic "committer_email_pattern" {
      for_each = each.value.rules.committer_email_pattern != null ? [each.value.rules.committer_email_pattern] : []
      content {
        name     = committer_email_pattern.value.name
        negate   = committer_email_pattern.value.negate
        operator = committer_email_pattern.value.operator
        pattern  = committer_email_pattern.value.pattern
      }
    }
    dynamic "copilot_code_review" {
      for_each = each.value.rules.copilot_code_review != null ? [each.value.rules.copilot_code_review] : []
      content {
        review_draft_pull_requests = copilot_code_review.value.review_draft_pull_requests
        review_on_push             = copilot_code_review.value.review_on_push
      }
    }
    creation = each.value.rules.creation
    deletion = each.value.rules.deletion
    dynamic "file_extension_restriction" {
      for_each = each.value.rules.file_extension_restriction != null ? [each.value.rules.file_extension_restriction] : []
      content {
        restricted_file_extensions = file_extension_restriction.value.restricted_file_extensions
      }
    }
    dynamic "file_path_restriction" {
      for_each = each.value.rules.file_path_restriction != null ? [each.value.rules.file_path_restriction] : []
      content {
        restricted_file_paths = file_path_restriction.value.restricted_file_paths
      }
    }
    dynamic "max_file_path_length" {
      for_each = each.value.rules.max_file_path_length != null ? [each.value.rules.max_file_path_length] : []
      content {
        max_file_path_length = max_file_path_length.value.max_file_path_length
      }
    }
    dynamic "max_file_size" {
      for_each = each.value.rules.max_file_size != null ? [each.value.rules.max_file_size] : []
      content {
        max_file_size = max_file_size.value.max_file_size
      }
    }
    dynamic "merge_queue" {
      for_each = each.value.rules.merge_queue != null ? [each.value.rules.merge_queue] : []
      content {
        check_response_timeout_minutes    = merge_queue.value.check_response_timeout_minutes
        grouping_strategy                 = merge_queue.value.grouping_strategy
        max_entries_to_build              = merge_queue.value.max_entries_to_build
        max_entries_to_merge              = merge_queue.value.max_entries_to_merge
        merge_method                      = merge_queue.value.merge_method
        min_entries_to_merge              = merge_queue.value.min_entries_to_merge
        min_entries_to_merge_wait_minutes = merge_queue.value.min_entries_to_merge_wait_minutes
      }
    }
    non_fast_forward = each.value.rules.non_fast_forward
    dynamic "pull_request" {
      for_each = each.value.rules.pull_request != null ? [each.value.rules.pull_request] : []
      content {
        allowed_merge_methods             = pull_request.value.allowed_merge_methods
        dismiss_stale_reviews_on_push     = pull_request.value.dismiss_stale_reviews_on_push
        require_code_owner_review         = pull_request.value.require_code_owner_review
        require_last_push_approval        = pull_request.value.require_last_push_approval
        required_approving_review_count   = pull_request.value.required_approving_review_count
        required_review_thread_resolution = pull_request.value.required_review_thread_resolution
        dynamic "required_reviewers" {
          for_each = pull_request.value.required_reviewers != null ? pull_request.value.required_reviewers : []
          content {
            file_patterns     = required_reviewers.value.file_patterns
            minimum_approvals = required_reviewers.value.minimum_approvals
            reviewer {
              id   = required_reviewers.value.reviewer.id
              type = required_reviewers.value.reviewer.type
            }
          }
        }
      }
    }
    dynamic "required_code_scanning" {
      for_each = each.value.rules.required_code_scanning != null ? [each.value.rules.required_code_scanning] : []
      content {
        dynamic "required_code_scanning_tool" {
          for_each = required_code_scanning.value.required_code_scanning_tool
          content {
            alerts_threshold          = required_code_scanning_tool.value.alerts_threshold
            security_alerts_threshold = required_code_scanning_tool.value.security_alerts_threshold
            tool                      = required_code_scanning_tool.value.tool
          }
        }
      }
    }
    dynamic "required_deployments" {
      for_each = each.value.rules.required_deployments != null ? [each.value.rules.required_deployments] : []
      content {
        required_deployment_environments = required_deployments.value.required_deployment_environments
      }
    }
    required_linear_history = each.value.rules.required_linear_history
    required_signatures     = each.value.rules.required_signatures
    dynamic "required_status_checks" {
      for_each = each.value.rules.required_status_checks != null ? [each.value.rules.required_status_checks] : []
      content {
        do_not_enforce_on_create = required_status_checks.value.do_not_enforce_on_create
        dynamic "required_check" {
          for_each = required_status_checks.value.required_check
          content {
            context        = required_check.value.context
            integration_id = required_check.value.integration_id
          }
        }
        strict_required_status_checks_policy = required_status_checks.value.strict_required_status_checks_policy
      }
    }
    dynamic "tag_name_pattern" {
      for_each = each.value.rules.tag_name_pattern != null ? [each.value.rules.tag_name_pattern] : []
      content {
        name     = tag_name_pattern.value.name
        negate   = tag_name_pattern.value.negate
        operator = tag_name_pattern.value.operator
        pattern  = tag_name_pattern.value.pattern
      }
    }
    update                        = each.value.rules.update
    update_allows_fetch_and_merge = each.value.rules.update_allows_fetch_and_merge
  }

  dynamic "bypass_actors" {
    for_each = each.value.bypass_actors != null ? each.value.bypass_actors : []
    content {
      actor_id    = bypass_actors.value.actor_id
      actor_type  = bypass_actors.value.actor_type
      bypass_mode = bypass_actors.value.bypass_mode
    }
  }

  dynamic "conditions" {
    for_each = each.value.conditions != null ? [each.value.conditions] : []
    content {
      ref_name {
        exclude = conditions.value.ref_name.exclude
        include = conditions.value.ref_name.include
      }
    }
  }
}

