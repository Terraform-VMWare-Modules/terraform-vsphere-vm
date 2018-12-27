variable "vmname" {
  description = "The name of the virtual machine used to deploy the vms"
  default     = "terraformvm"
}
variable "vmtemp" {
  description = "(Required)Name of the template available in the vSphere"
}
variable "is_windows_image" {
  description = "Boolean flag to notify when the custom image is windows based."
  default     = "false"
}
variable "data_disk_size_gb" {
  description = "Storage data disk size size"
  default     = ""
}
variable "data_disk" {
  type        = "string"
  description = "Set to true to add a datadisk."
  default     = "false"
}
variable "instances" {
  description = "number of instances you want deploy from the template"
  default = 1
}
variable "cpu_number" {
  description = "number of CPU (core per CPU) for the VM"
  default = 2
}
variable "ram_size" {
  description = "VM RAM size in megabytes"
  default = 4096
}
variable "vlan" {
  description = "(Required)VLAN name where the VM should be deployed"
}
variable "ipv4submask" {
  description = "ipv4 Subnet mask"
  default = 24
}
variable "ipaddress" {
  description = "host(VM) IP address in list format, support more than one IP. Should correspond to number of instances"
  type    = "list"
  default = ["10.0.0.1"]
}
variable "vmdomain" {
  description = "default VM domain for linux guest customization"
  default = "Development"
}
variable "dc" {
  description = "(Required)Name of the datacenter you want to deploy the VM to"
}
variable "vmrp" {
  description = "(Required)Cluster resource pool that VM will be deployed to. you use following to choose default pool in the cluster (esxi1) or (Cluster)/Resources"
}
variable "ds_cluster" {
  description = "(Required)Datastore cluster to deploy the VM."
}
variable "vmfolder" {
  default = "Discovered virtual machine"
}
variable "vmgateway" {
  description = "VM gateway to set during provisioning"
  default = ""
}
variable "vmdns" {
  type = "list"
  default = ["8.8.8.8","1.1.1.1"]
   }
variable "winadminpass" {
  description = "The administrator password for this virtual machine."
  default = "Str0ngP@ssw0rd!"
}



