resource "proxmox_vm_qemu" "srv_demo_1" {
    name = "srv-demo-1"
    desc = "Ubuntu Server"
    valid = "401"
    target_node = "proxmox"

    agent = 1
    clone = "ubunut-server-focal"
}



