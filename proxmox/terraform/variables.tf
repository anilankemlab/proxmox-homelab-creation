variable "proxmox_api_url" {
  description = "Proxmox API base URL, e.g. https://proxmox.example.com:8006/api2/json"
  type        = string
}

variable "proxmox_token_id" {
  description = "Proxmox API token ID, e.g. terraform@pve!github"
  type        = string
}

variable "proxmox_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

# variable "proxmox_api_token" {
#   type      = string
#   sensitive = true
# }

variable "node_name" {
  description = "Proxmox node where the VM will run"
  type        = string
  default = "proxmox"
}

variable "vm_name" {
  description = "Name of the VM to create"
  type        = string
}

variable "template_name" {
  description = "Name of the Proxmox VM template to clone from"
  type        = string
  default     = "ubuntu24-golden"
}

variable "full_clone" {
  description = "Whether to perform a full clone instead of a linked clone"
  type        = bool
  default     = true
}

variable "vm_cores" {
  description = "Number of vCPUs for the VM"
  type        = number
  default     = 2
}

variable "vm_memory_mb" {
  description = "Amount of RAM for the VM in megabytes"
  type        = number
  default     = 2048
}

variable "disk_size_gb" {
  description = "Disk size for the VM in gigabytes"
  type        = number
  default = 20
}

variable "disk_storage" {
  description = "Proxmox storage ID used for the VM disk (e.g. local-lvm)"
  type        = string
  default     = "local-lvm"
}

variable "vm_tags" {
  description = "Optional tags to apply to the VM"
  type        = list(string)
  default     = []
}

