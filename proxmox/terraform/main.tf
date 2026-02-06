resource "proxmox_vm_qemu" "vm_from_template" {
  name        = var.vm_name
  target_node = var.node_name

  # Clone from an existing template
  clone = var.template_name

  cores  = var.vm_cores
  memory = var.vm_memory_mb

  cpu {
    sockets = 1
  }

  tags = length(var.vm_tags) > 0 ? join(";", var.vm_tags) : null

  disk {
    size    = "${var.disk_size_gb}G"
    type    = "scsi"
    slot    = "scsi0"
    storage = var.disk_storage
  }

  # Reasonable defaults
  onboot = true
  scsihw = "virtio-scsi-pci"
}

