# Aethir CLI deployment with Tencent Cloud Lighthouse
This solution deploys a Terraform stack for Aethir CLI Tencent Cloud. It uses Lighthouse as main compute service alongside other necessary resources.

# Pre-requisites
## Tencent Cloud Account Creation and Setup
Please follow the below procedures to set-up your Tencent Cloud Account
 - Contact our partner( [telegram](https://t.me/mizukate) ) to get an account
 - Better to follow [best practices](https://www.tencentcloud.com/document/product/598/10592) for enhancing the security

## Deployment Configuration
The deployment is made with terraform, directly through the API of the Tencent Cloud Account created in the step above. To achieve the deployment, the environment must be set-up. Here are the steps:

### Step1 - Generate new Tencent Cloud API keys
For root account: https://www.tencentcloud.com/document/product/598/34228

For sub-account: https://www.tencentcloud.com/document/product/598/32675

### Step2 - Install Terraform
Install terraform: https://developer.hashicorp.com/terraform/install

### Step3 - Configure Tencent Cloud API keys for Terraform
Follow the instructions in section "Environment variables": https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs

# Solution Deployment
## Quick start
Here we create a new dir `demo`.

File structure:
```
demo
└── main.tf
```

The content of `main.tf`:
```hcl
module "aethir" {
  source         = "github.com/ritch2022/terraform-tencentcloud-aethir-node"
  prefix         = "demo"
  instance_count = 1
  firewall_rules = [{
    protocol                  = "TCP"
    port                      = "22"
    cidr_block                = "14.110.1.0/24"
    action                    = "ACCEPT"
    firewall_rule_description = "port required by SSH"
  }]
  purchase_period = 1
}
```

Having the configuration done, continue with these commands:
- `terraform init`
- `terraform plan`
- `terraform apply` select yes, enter

## Main parameters
|Parameter|Required|Default|Description|
|--|--|--|--|
|prefix|Yes||Prefix used to set different resources' name|
|instance_count|Yes||The number of Lighthouse instances|
|purchase_period|Yes||[Subscription period in months](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/lighthouse_instance#period)|
|firewall_rules|Yes||Lighthouse instance firewall rules|
|bundle_id|No|bundle_gen_nmc_lin_med2_01|[Lighthouse instance package](https://www.tencentcloud.com/document/product/1103/43335). default package is 2 core, 2 GB memory with 60 GiB SSD. No need to change.|
|blueprint_id|No|lhbp-qnuz61zs|[The image of Lighthouse instance](https://www.tencentcloud.com/document/product/1103/43335), default is Ubuntu 22.04 LTS. No need to change.|
|renew_flag|No|NOTIFY_AND_MANUAL_RENEW|[Auto-Renewal flag](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/lighthouse_instance#renew_flag)|
