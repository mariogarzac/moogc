variable "vmid" {
  description = "Unique VMID for the LXC container"
  type        = number
}

variable "hostname" {
  description = "Hostname for the container"
  type        = string
}

variable "target_node" {
  description = "Proxmox node to deploy on"
  type        = string
  default     = "internal"
}

variable "ostemplate" {
  description = "LXC template to clone from, e.g. local:vztmpl/ubuntu-26.04-standard_26.04-1_amd64.tar.zst"
  type        = string
}

variable "cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 1
}

variable "memory" {
  description = "Memory in MB"
  type        = number
  default     = 2048
}

variable "swap" {
  description = "Swap in MB"
  type        = number
  default     = 512
}

variable "disk_size" {
  description = "Root disk size, e.g. \"20G\""
  type        = string
  default     = "20G"
}

variable "storage" {
  description = "Storage pool for the root disk"
  type        = string
  default     = "vm-ssd"
}

variable "unprivileged" {
  description = "Whether the container is unprivileged"
  type        = bool
  default     = true
}

variable "bridge" {
  description = "Network bridge to attach to"
  type        = string
  default     = "vmbr0"
}

variable "ip" {
  description = "IP address with CIDR, e.g. 192.168.71.160/22"
  type        = string
}

variable "gw" {
  description = "Gateway IP"
  type        = string
}

variable "nameserver" {
  description = "DNS server for the container"
  type        = string
  default     = "192.168.100.1"
}

variable "ssh_public_key" {
  description = "SSH public key for root/admin access"
  type        = string
}

variable "start_on_boot" {
  description = "Whether the container should start when the Proxmox node boots"
  type        = bool
  default     = true
}

variable "ssh_private_key_path" {
  description = "SSH private key path"
  type        = string
}
