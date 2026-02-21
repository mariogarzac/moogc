resource "proxmox_vm_qemu" "clawbot" {
  vmid               = var.vmid
  name               = var.name
  description        = "clawbot vm"
  target_node        = "proxmox"

  start_at_node_boot = true
  agent              = 1

  clone              = "ubuntu-server"
  memory             = "4096"
  scsihw             = "virtio-scsi-pci"

  cpu {
    type    = "host"
    cores   = 2
    sockets = 2
  }

  network {
    id       = "0"
    bridge   = "vmbr0"
    model    = "virtio"
    firewall = true
  }

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local"
        }
      }
    }

    virtio {
      virtio0 {
        disk {
          size    = "40G"
          storage = "local"
        }
      }
    }
  }

  # Cloud-init settings
  os_type   = "cloud-init"
  ipconfig0 = var.ipconfig
  ciuser    = "mario"
  sshkeys   = ""
}

