# AWS WAF Advanced Rules with Terraform

:star: don't forget star us on GitHub, please, it motivates me to keep writing new rules!

[AWS Waf Advanced Rules with Terraform](https://github.com/glaucius/aws-waf-terraform-advanced-rules) is just a place where you can find some awesome and complex rules to AWS WAF, written on top of Terraform, in order to automate your WAF rules to AWS. It is based on a sigle rule group, but I suggest you to split your rules into groups, to allow it to be used as much granularity as possible.

## Installation

If you already have Terraform and AWS CLI proper configured and running, you don't need anything else to move forward.

### Terraform

To install Terraform, folow this steps -->  [Setup Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### AWS CLI

To install and setup AWS CLI, folow this steps --> [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)


### Deploy

To deploy it, you will need Terraform binaries and AWS CLI up and running in your environment, do not forget to see the files, check names and variables, and then, realy simple:

Init your terraform flow
```bash
terraform init
```

Plan your deployment
```bash
terraform plan
```

Apply your deployment
```bash
terraform apply -auto-approve
```

### Destroy

Just run this command to distroy all stack:
```bash
terraform destroy
```

### Rules Description

## Rule AWSRateBasedRuleDomesticDOS

Block requests that match the rule, in this case the rule blocks requests from a single IP address, that comes from Brazil if they are higher than 2000 requests per 5 minutes range of time.

* Block all requests that goes higher than 2000 per 5 minutes
* It works only when the request comes from Brazil
* Enables visibility on AWS CloudWatch metrics

## Rule AWSRateBasedRulePerFqdnorServiceAndDomesticDOS

It does almost the same than the previus rule, but it has another statement that demands a match between 'host' header and a string. So, it blocks requests when it is higher than 500 requests, needs to match country code with Brazil and 'app.foo.bar' as hostaname or fqdn.

* Block all requests that goes higher than 500 per 5 minutes
* It works only when the request comes from Brazil
* Need to match host header with value 'app.foo.bar'
* Enables visibility on AWS CloudWatch metrics

## License

This project is distributed under the GPL v3 License. See the LICENSE file for more details.

## Help

If you need assistance or have any questions, we're here to help! Check out the following resources:

- **Issues**: If you encounter any bugs or have feature requests, please open an [issue](https://github.com/glaucius/aws-waf-terraform-advanced-rules/issues) on our GitHub repository.

Feel free to reach out if you have any questions or concerns. I value your feedback and I'm dedicated to making your experience with my rules as smooth as possible.
