resource "proxmox_vm_qemu" "dev" {
  vmid        = var.vmid
  name        = var.name
  desc        = "dev environment"
  target_node = "proxmox"

  onboot = true
  agent  = 1

  clone   = "ubuntu-jammy"
  cloudinit_cdrom_storage = "local"
  cores   = 2
  sockets = 2
  cpu     = "host"
  memory  = "16384"
  scsihw  = "virtio-scsi-pci"

  network {
    bridge   = "vmbr0"
    model    = "virtio"
    firewall = true
  }

  disks {
    virtio {
      virtio0 {
        disk {
          size    = "50"
          storage = "local"
        }
      }
    }
  }

  os_type   = "cloud-init"
  ipconfig0 = var.ipconfig
  ciuser    = "mariomoo"
  sshkeys   = ""
}

