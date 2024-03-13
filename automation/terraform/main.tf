# Define module
module "kube" {
  source   = "./kube"
  vmid     = "106"
  name     = "kube4"
  ipconfig = "ip=192.168.68.106/24,gw=192.168.68.1"
}
