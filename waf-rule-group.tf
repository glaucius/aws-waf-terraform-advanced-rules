
resource "aws_wafv2_regex_pattern_set" "waf_regex_pattern" {
  name  = "waf_regex_pattern"
  scope = "REGIONAL"

  regular_expression {
    regex_string = "some-string"
  }
}

resource "aws_wafv2_rule_group" "waf_rule_group" {
  name        = "AWS-WAF-Rule-Group"
  description = "An rule group containing all statements to rule group"
  scope       = "REGIONAL"
  capacity    = 500


  rule {
    name     = "AWSRateBasedRuleDomesticDOS"
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 2000
        aggregate_key_type = "IP"

        scope_down_statement {
          geo_match_statement {
            country_codes = ["BR"]
          }
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSRateBasedRuleDomesticDOS"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSRateBasedRulePerFqdnorServiceAndDomesticDOS"
    priority = 2

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 500
        aggregate_key_type = "IP"

        scope_down_statement {
          and_statement {
            statement {

              geo_match_statement {
                country_codes = ["BR"]
              }
            }

            statement {
              byte_match_statement {
                positional_constraint = "CONTAINS"
                search_string         = "app.foo.bar"

                field_to_match {
                  headers {
		     match_scope = "ALL"
		     oversize_handling = "CONTINUE"
		     match_pattern {
			all{}
		     }
		  } 
                }

               text_transformation {
                 priority = 1
                 type     = "NONE"
               }
		
              }
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSRateBasedRulePerFqdnorServiceAndDomesticDOS"
      sampled_requests_enabled   = true
    }
  }


  rule {
    name     = "rule-1"
    priority = 3

    action {
      block {}
    }

    statement {

      not_statement {
        statement {

          and_statement {
            statement {

              geo_match_statement {
                country_codes = ["US"]
              }
            }

            statement {

              byte_match_statement {
                positional_constraint = "CONTAINS"
                search_string         = "word"

                field_to_match {
                  all_query_arguments {}
                }

                text_transformation {
                  priority = 5
                  type     = "CMD_LINE"
                }

                text_transformation {
                  priority = 2
                  type     = "LOWERCASE"
                }
              }
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "rule-1"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "rule-2"
    priority = 4

    action {
      count {}
    }

    statement {

      or_statement {
        statement {

          regex_match_statement {

            regex_string = "[a-z]([a-z0-9_-]*[a-z0-9])?"

            field_to_match {
              single_header {
                name = "user-agent"
              }
            }

            text_transformation {
              priority = 6
              type     = "NONE"
            }
          }
        }

        statement {

          sqli_match_statement {

            field_to_match {
              body {}
            }

            text_transformation {
              priority = 5
              type     = "URL_DECODE"
            }

            text_transformation {
              priority = 4
              type     = "HTML_ENTITY_DECODE"
            }

            text_transformation {
              priority = 3
              type     = "COMPRESS_WHITE_SPACE"
            }
          }
        }

        statement {

          xss_match_statement {

            field_to_match {
              method {}
            }

            text_transformation {
              priority = 2
              type     = "NONE"
            }
          }
        }
      }
     
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "rule-2"
      sampled_requests_enabled   = false
    }

  }

  rule {
    name     = "rule-3"
    priority = 5

    action {
      block {}
    }

    statement {

      size_constraint_statement {
        comparison_operator = "GT"
        size                = 100

        field_to_match {
          single_query_argument {
            name = "username"
          }
        }

        text_transformation {
          priority = 5
          type     = "NONE"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "rule-3"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "rule-4"
    priority = 6

    action {
      block {}
    }

    statement {

      or_statement {
        statement {

          ip_set_reference_statement {
            arn = aws_wafv2_ip_set.ip_set.arn
          }
        }

        statement {

          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.waf_regex_pattern.arn

            field_to_match {
              single_header {
                name = "referer"
              }
            }

            text_transformation {
              priority = 2
              type     = "NONE"
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "rule-4"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "friendly-metric-name"
    sampled_requests_enabled   = false
  }


  tags = {
    Name = "example-and-statement"
    Code = "123456"
  }
}
