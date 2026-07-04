# Ubuntu Server Jammy
# ---
# Packer Template to create an Ubuntu Server (Jammy) on Proxmox

# Variable Definitions
variable "proxmox_api_url" {}
variable "proxmox_api_token_id" {}
variable "proxmox_api_token_secret" {}
variable "node" {}
variable "memory" {}
variable "vm_id" {}
variable "vm_name" {}
variable "template_description" {}
variable "disk_size" {}
variable "cores" {}

# Resource Definition for the VM Template
source "proxmox-iso" "ubuntu-template" {

  # Proxmox Connection Settings
  proxmox_url              = "${var.proxmox_api_url}"
  username                 = "${var.proxmox_api_token_id}"
  token                    = "${var.proxmox_api_token_secret}"
  insecure_skip_tls_verify = true

  # VM General settings
  node                 = var.node
  vm_id                = var.vm_id
  vm_name              = var.vm_name
  template_description = var.template_description

  # VM OS Settings
  boot_iso {
    iso_file = "local:iso/ubuntu-22.04.5-live-server-amd64.iso"
    iso_storage_pool = "local"
  }

  # VM System Settings
  qemu_agent = true

  # VM Hard Disk Settings
  scsi_controller = "virtio-scsi-pci"

  disks {
    disk_size    = var.disk_size
    format       = "raw"
    storage_pool = "local"
    type         = "virtio"
  }

  # VM CPU Settings
  cores = var.cores

  # VM Memory Settings
  memory = var.memory

  # VM Network Settings
  network_adapters {
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = "false"
  }

  # VM Cloud-Init Settings
  cloud_init              = true
  cloud_init_storage_pool = "local"

  # PACKER Boot Commands
  boot_command = [
    "<esc><wait>",
    "e<wait>",
    "<down><down><down><end>",
    "<bs><bs><bs><bs><wait>",
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"
  ]
  boot      = "c"
  boot_wait = "5s"

  # PACKER Autoinstall Settings
  # http_bind_address = "192.168.71.120"
  http_directory = "config"
  http_port_min  = 8802
  http_port_max  = 8802

  # SSH Settings
  ssh_username         = "mario"
  ssh_private_key_file = "~/.ssh/homelab"

  ssh_timeout = "20m"

}

# Build Definition to create the VM Template
build {
  name    = "ubuntu-template"
  sources = ["source.proxmox-iso.ubuntu-template"]

  # Provisioning the VM Template for Cloud-Init Integration in Proxmox #1
  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
      "sudo rm /etc/ssh/ssh_host_*",
      "sudo truncate -s 0 /etc/machine-id",
      "sudo apt -y autoremove --purge",
      "sudo apt -y clean",
      "sudo apt -y autoclean",
      "sudo cloud-init clean",
      "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
      "sudo sync"
    ]
  }

  # Provisioning the VM Template for Cloud-Init Integration in Proxmox #2
  provisioner "file" {
    source      = "files/99-pve.cfg"
    destination = "/tmp/99-pve.cfg"
  }

  # Provisioning the VM Template for Cloud-Init Integration in Proxmox #3
  provisioner "shell" {
    inline = ["sudo cp /tmp/99-pve.cfg /etc/cloud/cloud.cfg.d/99-pve.cfg"]
  }

  # Provisioning the VM Template with Docker Installation #4
  provisioner "shell" {
    inline = [
      "sudo apt-get install -y ca-certificates curl gnupg lsb-release",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get -y update",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",
      "sudo usermod -aG docker mario"
    ]
  }

  # Provisioning the VM Template with Tailscale Installation #5
  provisioner "shell" {
    inline = [
    "curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null",
    "curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list",
    "sudo apt-get update",
    "sudo apt-get install tailscale -y",
    ]
  }
}
