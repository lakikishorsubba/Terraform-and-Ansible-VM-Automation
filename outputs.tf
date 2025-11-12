output "vm_ips" {
  description = "IP addresses of provisioned VMs"
  value = {
    for name, config in var.vms : name => config.ip
  }
}

output "ansible_inventory" {
  description = "Ansible inventory content"
  value       = local_file.ansible_inventory.content
}

output "inventory_file" {
  description = "Path to Ansible inventory file"
  value       = local_file.ansible_inventory.filename
}
