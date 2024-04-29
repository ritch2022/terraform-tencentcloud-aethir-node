terraform {
  required_version = ">=1.5"
  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = ">= 1.81.32"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.1"
    }
  }
}

provider "random" {
  # Configuration options
}
