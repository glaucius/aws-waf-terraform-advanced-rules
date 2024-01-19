resource "aws_wafv2_web_acl" "web_acl" {
  name        = "web_acel"
  description = "Example of a managed web_acl using a rule group."
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "web_acl_rule_group"
    priority = 1

    override_action {
      count {}
    }

    statement {
      rule_group_reference_statement {
        arn = aws_wafv2_rule_group.waf_rule_group.arn

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "rule-to-exclude-b"
        }

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "rule-to-exclude-a"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "friendly-rule-metric-name"
      sampled_requests_enabled   = false
    }
  }

  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "waf-web-acl"
    sampled_requests_enabled   = true
  }
}
