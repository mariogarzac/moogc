# IaC With Packer and Terraform

## Intro
For most of this project I followed Christian Lempa's videos on Packer and terraform, but those were a little outdated and needed some extra work and reasearch done.
Packer and Terraform installation are the same as described in the videos, however the configuration file's syntax changes a little bit. RTFM actually helped this time.
This is currently working for Proxmox version 8.1.4 with Ubuntu Server 22.04 LTS.

## Setup
First step is to setup an API token for Packer using the Proxmox GUI.
- Datacenter
- API Tokens
- Add 
- Give the token an ID and uncheck the privilage separation.

This token will go in the credentials file along side the token id and url.

To install Packer and Terraform
```
# Packer
brew tap hashicorp/tap
brew install hashicorp/tap/packer

# Terraform
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```


## Packer Template 
The template itself is pretty self explanatory, however there are a few key points.
First, be sure to have the cloud-init setting set to true, since this is how we 
will be configuring VMs with Terraform. Secondly, the disk specifications in Packer
will need to match the ones in Terraform, so keep that in mind.

Next is the config where general OS settings will be described, such as locale and ssh.
Ssh needs to be configured since this is how Packer will provision the template. It is also important 
to have the name in the users section be the same as the one established in the template.

## Packer Build 
After configuring the template, you can run `packer validate` to validate the template files and then
`packer build -var-file='../credentials.pkr.hcl' 'jammy.pkr.hcl'` to create the template. If everything goes well, in about 8-10 
minutes you will a new template with docker and tailscale preinstalled.

## Packer Troubleshooting
Sometimes Packer will crash and display a big error, though, in my experience running it again usually fixes it. When the OS gui is shown
this means that Packer could not connect through ssh, for me, the problem was that my user-data file was not correctly indented or had syntax errors.

## Terraform Template
Terraforms template is pretty straight forward. I created a directory called kube which has the specifications for the vm, with variables 
and the provider in that same folder. For some reason Terraform needs the variables to exist in each module and in the root, maybe that's something I misconfigured, but idk.
My biggest problem was figuring out why my cloud-init drive was being erased and it turned out that I did not need to create 
a special ide0 drive for it, but instead just had to set the cloudinit_cdrom_storage variable to "local". Also reading the docs really helped.

Lastly in the root I have a main.tf file which specifies the vmid, name and ipconfig. For the ipconfig, having the ip and then the gw did not work, but once 
I change it to gw and then ip it worked perfectly.

## Creating the VM with Terraform
After creating the kube module and the main.tf, I ran `terraform init` to initialize the project.
Then `terraform plan` to let Terraform know what I am going to build.
And lastly `terraform apply -auto-approve` to begin creating the VMs without having to type yes.

Now Terraform will create the VMs from the template specified in the configuration files, in about 2 minutes.

## Resources 
### Packer
https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli
https://www.youtube.com/watch?v=1nf3WOEFq1Y

### Terraform
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
https://www.youtube.com/watch?v=dvyeoDBUtsU&t=149s
https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu
