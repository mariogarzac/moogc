resource "proxmox_vm_qemu" "kube" {
  vmid        = var.vmid
  name        = var.name
  desc        = "Kubernetes node"
  target_node = "proxmox"

  onboot = true
  agent  = 1

  clone   = "ubuntu-jammy-ci"
  cloudinit_cdrom_storage = "local"
  cores   = 1
  sockets = 1
  cpu     = "kvm64"
  memory  = "2048"
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
          size    = "20"
          storage = "local"
        }
      }
    }
  }

  os_type   = "cloud-init"
  ipconfig0 = var.ipconfig
  ciuser    = "moo"
  sshkeys   = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpAFVAp647UneXqjqTd5xUKxr7u/PerxHoTG96T5jUDrUkwHT4q6yvI1GIvHkkOsRN0GkUYLJtfniScIdzQbKOAXXy/ly91YMsc6ecaIV7Cu11ulmpNQFOMRW3qgBrJ9bi5RlJ8c05vFfJ5C0Pmdg5GNANCWHwHoQOEZZ9LxVZbLqjFJurAqX4T/W8OBQ0OsK7r4FnFLSpsyXRkZQqOimXVWrANE1s6eg66CyeOVZriSSGfBJxOMZw9WuXAwjTHMjh2zigBTDEEZ3776D9WOkix46mT3IKJW+KDU3X09rxET2/wNCOP4BHSm4kPUO13Bk+Vt37mFkxSyAF4lszfLftLwTTptjtqOAyfAdV/TCHMMmlCj8UEzFEJWHMEsONR8fjnnoEmeYaqivn2ZQnLOS5XTaX9PdwdZfzE8PG7ocpPe2gi5MFY9YtlL/mA23Hz91KZeff0+/rEoeCxYpRnBTiLGAVYQGKkGBL7VhAQGzTgMq1E+EVWAvVcKIGEjPm7sk= mariogarza@kravaraad.local"
}
