variable "vmid" {
  type = string
}

variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = ""
}

variable "target_node" {
  type    = string
  default = "internal"
}

variable "clone" {
  description = "Name of the template to clone"
  type        = string
}

variable "cores" {
  type    = number
  default = 2
}

variable "sockets" {
  type    = number
  default = 1
}

variable "memory" {
  description = "Memory in MB"
  type        = number
  default     = 2048
}

variable "disk_size" {
  description = "Primary disk size, e.g. '50G'"
  type        = string
  default     = "20G"
}

variable "storage" {
  description = "Storage pool for disk + cloudinit"
  type        = string
  default     = "vm-ssd"
}

variable "bridge" {
  type    = string
  default = "vmbr0"
}

variable "firewall" {
  type    = bool
  default = true
}

variable "start_at_node_boot" {
  type    = bool
  default = true
}

variable "agent" {
  type    = number
  default = 1
}

variable "ipconfig" {
  type = string
}

variable "ciuser" {
  type    = string
  default = "mario"
}

variable "ssh_public_key" {
  type = string
}
