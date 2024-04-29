output "lighthouse_instance_ids" {
  value       = tencentcloud_lighthouse_instance.this[*].id
  description = "Lighthouse instance id list"
}

output "TAT_command_name" {
  value       = tencentcloud_tat_command.this.command_name
  description = "TAT command name"
}
