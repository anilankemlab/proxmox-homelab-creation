output "vm_node" {
  description = "Proxmox node where VM is created"
  value       = proxmox_virtual_environment_vm.vm_from_template.node_name
}

output "vm_tags" {
  description = "Tags assigned to VM"
  value       = proxmox_virtual_environment_vm.vm_from_template.tags
}
