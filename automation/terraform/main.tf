# Define module
module "k8-1" {
  source   = "./kube"
  vmid     = "201"
  name     = "k8-1"
  ipconfig = "gw=192.168.68.1,ip=192.168.68.103/22"
}

module "k8-2" {
  source   = "./kube"
  vmid     = "202"
  name     = "k8-2"
  ipconfig = "gw=192.168.68.1,ip=192.168.68.104/22"
}

module "k8-3" {
  source   = "./kube"
  vmid     = "203"
  name     = "k8-3"
  ipconfig = "gw=192.168.68.1,ip=192.168.68.105/22"
}
