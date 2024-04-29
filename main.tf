locals {
  installer = "/scripts/setup.sh"
}

resource "random_id" "this" {
  byte_length = 6
}

resource "tencentcloud_lighthouse_firewall_template" "this" {
  template_name = "${var.prefix}-template"
  dynamic "template_rules" {
    for_each = var.firewall_rules
    content {
      protocol                  = lookup(template_rules.value, "protocol", "")
      port                      = lookup(template_rules.value, "port", "")
      cidr_block                = lookup(template_rules.value, "cidr_block", "")
      action                    = lookup(template_rules.value, "action", "")
      firewall_rule_description = lookup(template_rules.value, "firewall_rule_description", "")
    }
  }
}

resource "tencentcloud_lighthouse_instance" "this" {
  count                = var.instance_count
  instance_name        = "${var.prefix}-node-${count.index}"
  bundle_id            = var.bundle_id
  blueprint_id         = var.blueprint_id
  period               = var.purchase_period
  renew_flag           = var.renew_flag
  firewall_template_id = tencentcloud_lighthouse_firewall_template.this.id

  provisioner "local-exec" {
    command = "sleep 1"
  }
}

resource "tencentcloud_tat_command" "this" {
  command_name      = "${var.prefix}-${random_id.this.hex}"
  content           = file("${path.module}${local.installer}")
  description       = "install Aethir CLI"
  command_type      = "SHELL"
  timeout           = "60"
  username          = "ubuntu"
  working_directory = "/home/ubuntu"
  enable_parameter  = false
}

resource "tencentcloud_tat_invocation_invoke_attachment" "this" {
  count       = var.instance_count
  command_id  = tencentcloud_tat_command.this.id
  instance_id = tencentcloud_lighthouse_instance.this[count.index].id
  username    = "ubuntu"
  working_directory = "/home/ubuntu"

  depends_on = [tencentcloud_lighthouse_instance.this]
}
