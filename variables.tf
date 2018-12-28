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
  description = "default VM domain for linux guest customization or Windows when join_windomain is selected"
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

variable "join_windomain" {
  description = "Boolean flag to set when want join windows server to AD"
  default = "false"
}

variable "domainuser" {
  description = "Domain admin user to join the server to AD"
  default = "DomainAdmin"
}

variable "domainpass" {
  description = "Doamin User pssword to join the server to AD"
  default = "Str0ngP@ssw0rd!"
}
variable "orgname" {
  description = "Organization name for when joining windows server to AD"
  default = "Terraform"
}
variable "run_once" {
  description = "List of Comamnd to run during first logon (Automatic login set to 1)"
  type = "list"
  default = []
}

variable "productkey" {
  description = "Product key to be used during windows customization. Defualt set to win2k16 KMS"
  default = "WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY"
}

