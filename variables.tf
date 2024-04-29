variable "prefix" {
  type        = string
  description = "The prefix when setting name"
}

variable "instance_count" {
  type        = number
  description = "Lighthouse instance count"
}

variable "bundle_id" {
  type        = string
  description = "Lighthouse bundle id"
  default     = "bundle_gen_nmc_lin_med2_01"
}

variable "blueprint_id" {
  type        = string
  description = "Lighthouse blueprint id"
  default     = "lhbp-qnuz61zs" # ubuntu22
}

variable "renew_flag" {
  type        = string
  description = "Auto-Renewal flag"
  default     = "NOTIFY_AND_MANUAL_RENEW"
  validation {
    condition     = contains(["NOTIFY_AND_AUTO_RENEW", "NOTIFY_AND_MANUAL_RENEW", "DISABLE_NOTIFY_AND_AUTO_RENEW"], var.renew_flag)
    error_message = "Please choose one of the following: NOTIFY_AND_AUTO_RENEW, NOTIFY_AND_MANUAL_RENEW, DISABLE_NOTIFY_AND_AUTO_RENEW"
  }
}

variable "purchase_period" {
  type        = number
  description = "Purchase period"
  validation {
    condition     = contains([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 24, 36, 48, 60], var.purchase_period)
    error_message = "Please choose one of the following: 1,2,3,4,5,6,7,8,9,10,11,12,24,36,48,60"
  }
}

variable "firewall_rules" {
  type = list(object({
    protocol                  = string
    port                      = string
    cidr_block                = string
    action                    = string
    firewall_rule_description = string
  }))
  description = "Firewall rules for lighthouse instances"
}
