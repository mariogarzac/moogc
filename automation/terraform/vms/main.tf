resource "proxmox_vm_qemu" "vm" {
  vmid        = var.vmid
  name        = var.name
  description = var.description
  target_node = var.target_node

  agent              = var.agent
  start_at_node_boot = var.start_at_node_boot

  clone  = var.clone
  memory = var.memory
  scsihw = "virtio-scsi-pci"

  cpu {
    cores   = var.cores
    sockets = var.sockets
  }

  network {
    id       = 0
    bridge   = var.bridge
    model    = "virtio"
    firewall = var.firewall
  }

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = var.storage
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          size    = var.disk_size
          storage = var.storage
        }
      }
    }
  }

  os_type   = "cloud-init"
  ipconfig0 = var.ipconfig
  ciuser    = var.ciuser
  sshkeys   = var.ssh_public_key
}
