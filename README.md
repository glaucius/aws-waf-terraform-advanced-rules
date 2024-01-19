# AWS WAF Advanced Rules with Terraform

:star: don't forget star us on GitHub, please, it motivates me to keep writing new rules!

[AWS Waf Advanced Rules with Terraform](https://github.com/glaucius/aws-waf-terraform-advanced-rules) is just a place where you can find some awesome and complex rules to AWS WAF, written on top of Terraform, in order to automate your WAF rules to AWS. It is based on a sigle rule group, but I suggest you to split your rules into groups, to allow it to be used as much granularity as possible.

## Table Of Content

- [Installation](#installation)
    - [Terraform](#terraform)
    - [AWS CLI](#awscli)

## Installation

If you already have Terraform and AWS CLI proper configured and running, you don't need anything else to move forward.

### Terraform

To install Terraform, folow this steps -->  [Setup Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### AWS CLI

To install and setup AWS CLI, folow this steps --> [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)


### Deploy

To deploy it, you will need Terraform binaries and AWS CLI up and running in your environment, do not forget to see the files, check names and variables, and then, realy simple:

Init your terraform flow
```
terraform init
```
Plan your deployment
```
terraform plan
```
Apply your deployment
```
terraform apply -auto-approve
```

### Destroy

Just run this command:
```
terraform destroy
```

### Rules Description

## Rule AWSRateBasedRuleDomesticDOS

Priority: 1
Action: Block requests that match the rule, in this case the rule blocks requests from a single IP address, that comes from Brazil if they are higher than 2000 requests per 5 minutes range of time.
Statement:
Rate-Based Statement: Limit requests to 2000 per IP within a specified time window.
Scope Down Statement: Allow requests only from Brazil (country code "BR").
Visibility Configuration: Enable CloudWatch metrics with the specified metric name and enable sampling of requests.

## Rule AWSRateBasedRulePerFqdnorServiceAndDomesticDOS

Rule Name: AWSRateBasedRulePerFqdnorServiceAndDomesticDOS
Priority: 2
Action: Block requests that match the rule, in this case the rule blocks request from a single IP address, that comes from Brazil and uses "app.foo.bar" as a hostname, considering the Host header as value to be matched. If the amount of requests are higher than 500 during 5 minutes, well, it will block the source IP address.
Statement:
Rate-Based Statement: Limit requests to 500 per IP within a specified time window.
Scope Down Statement:
Geo Match Statement: Allow requests only from Brazil (country code "BR").
AND Statement:
Byte Match Statement: Block requests containing "app.foo.bar" in the specified header.
Visibility Configuration: Enable CloudWatch metrics with the specified metric name and enable sampling of requests.