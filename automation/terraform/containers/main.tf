resource "proxmox_lxc" "container" {
  vmid         = var.vmid
  hostname     = var.hostname
  target_node  = var.target_node
  ostemplate   = var.ostemplate

  cores        = var.cores
  memory       = var.memory
  swap         = var.swap

  unprivileged = var.unprivileged
  onboot       = var.start_on_boot
  start        = true

  features {
    nesting = true
  }

  rootfs {
    storage = var.storage
    size    = var.disk_size
  }

  network {
    name     = "eth0"
    bridge   = var.bridge
    ip       = var.ip
    gw       = var.gw
    firewall = true
  }

  nameserver = var.nameserver

  ssh_public_keys = var.ssh_public_key

  connection {
    type        = "ssh"
    host        = split("/", var.ip)[0]
    user        = "root"
    private_key = file(var.ssh_private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "id -u mario || useradd -m -s /bin/bash mario",
      "mkdir -p /home/mario/.ssh",
      "echo '${var.ssh_public_key}' > /home/mario/.ssh/authorized_keys",
      "chown -R mario:mario /home/mario/.ssh",
      "chmod 700 /home/mario/.ssh",
      "chmod 600 /home/mario/.ssh/authorized_keys",
      "usermod -aG sudo mario"
    ]
  }
}
