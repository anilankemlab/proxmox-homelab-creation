data "proxmox_virtual_environment_vms" "template" {
  node_name = var.node_name

   filter {
    name   = "name"
    values = [var.template_name]
  }
}

resource "proxmox_virtual_environment_vm" "vm_from_template" {

  name      = var.vm_name
  node_name = var.node_name

  tags = var.vm_tags

  clone {
    vm_id = data.proxmox_virtual_environment_vms.template.vms[0].vm_id
    full  = var.full_clone
  }

  cpu {
    cores = var.vm_cores
  }

  memory {
    dedicated = var.vm_memory_mb
  }

  disk {
    datastore_id = var.disk_storage
    interface    = "scsi0"
    size         = var.disk_size_gb
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  # operating_system {
  #   type = "l26"
  # }

  on_boot = true
}
