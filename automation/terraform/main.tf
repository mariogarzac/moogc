# Define module
module "minecraft" {
  source   = "./minecraft"
  vmid     = "110"
  name     = "minecraft"
  ipconfig = "gw=192.168.68.1,ip=192.168.71.110/22"
}

module "patosland" {
  source   = "./minecraft"
  vmid     = "111"
  name     = "patosland"
  ipconfig = "gw=192.168.68.1,ip=192.168.71.111/22"
}
