# Define module
module "dev" {
  source   = "./dev"
  vmid     = "105"
  name     = "dev"
  ipconfig = "gw=192.168.68.1,ip=192.168.71.100/22"
}

module "kmaster" {
  source   = "./kmaster"
  vmid     = "106"
  name     = "kmaster"
  ipconfig = "gw=192.168.68.1,ip=192.168.71.101/22"
}

module "kworker1" {
  source   = "./kworker1"
  vmid     = "107"
  name     = "kworker1"
  ipconfig = "gw=192.168.68.1,ip=192.168.71.102/22"
}

module "kworker2" {
  source   = "./kworker2"
  vmid     = "108"
  name     = "kworker2"
  ipconfig = "gw=192.168.68.1,ip=192.168.71.103/22"
}
