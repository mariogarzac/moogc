terraform {
    required_version = ">=0.13.0"

    required_providers {
        proxmox = {
            source = "telmate/proxmox"
       }
    }
}

variable "proxmox_api_url" {
    type = string
}

variable "proxmox_api_token_id" {
    type = string
    sensitive = true
}

variable "proxmox_api_token_secret" {
    type = string
    sensitive = true
}

provider "proxmox" {
    pm_api_url = var.proxmox.api_url
    pm_api_token_id = var.proxmox.api_token_id
    pm_api_token_secret = var.proxmox.api_token_secret

    pm_tls_insecure = true
}
