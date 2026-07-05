# Define containers
module "pihole" {
  source         = "./containers"
  vmid           = "110"
  hostname       = "pihole"
  ostemplate     = "local:vztmpl/ubuntu-26.04-standard_26.04-1_amd64.tar.zst"
  cores          = 1
  memory         = 512
  disk_size      = "10G"
  storage        = "vm-ssd"
  ip             = "192.168.71.110/22"
  gw             = "192.168.68.1"
  ssh_public_key = var.ssh_public_key
  ssh_private_key_path = var.ssh_private_key_path
}

module "postgres_dev" {
  source         = "./containers"
  vmid           = "111"
  hostname       = "postgres-dev"
  ostemplate     = "local:vztmpl/ubuntu-26.04-standard_26.04-1_amd64.tar.zst"
  storage        = "vm-ssd"
  cores          = 2
  memory         = 2048
  disk_size      = "20G"
  ip             = "192.168.71.111/22"
  gw             = "192.168.68.1"
  ssh_public_key = var.ssh_public_key
  ssh_private_key_path = var.ssh_private_key_path
}

module "gitea" {
  source                = "./containers"
  vmid                  = "112"
  hostname               = "gitea"
  ostemplate             = "local:vztmpl/ubuntu-26.04-standard_26.04-1_amd64.tar.zst"
  storage                = "vm-ssd"
  cores                  = 1
  memory                 = 1024
  disk_size              = "10G"
  ip                     = "192.168.71.112/22"
  gw                     = "192.168.68.1"
  ssh_public_key         = var.ssh_public_key
  ssh_private_key_path   = var.ssh_private_key_path
}

module "quartz_wiki" {
  source                = "./containers"
  vmid                  = "113"
  hostname               = "quartz-wiki"
  ostemplate             = "local:vztmpl/ubuntu-26.04-standard_26.04-1_amd64.tar.zst"
  storage                = "vm-ssd"
  cores                  = 1
  memory                 = 1024
  disk_size              = "10G"
  ip                     = "192.168.71.113/22"
  gw                     = "192.168.68.1"
  ssh_public_key         = var.ssh_public_key
  ssh_private_key_path   = var.ssh_private_key_path
}

# Define vms
module "minecraft" {
  source    = "./vms"
  vmid      = "150"
  name      = "minecraft"
  clone     = "minecraft-template"
  storage   = "vm-ssd"
  cores     = 2
  memory    = 6144
  disk_size = "50G"
  ipconfig  = "gw=192.168.68.1,ip=192.168.71.150/22"
  ssh_public_key = var.ssh_public_key
}

module "k8s" {
  source    = "./vms"
  vmid      = "151"
  name      = "k8s"
  clone     = "kubernetes-template"
  storage   = "vm-ssd"
  cores     = 2
  memory    = 6144
  disk_size = "40G"
  ipconfig  = "gw=192.168.68.1,ip=192.168.71.151/22"
  ssh_public_key = var.ssh_public_key
  start_at_node_boot = false
}
