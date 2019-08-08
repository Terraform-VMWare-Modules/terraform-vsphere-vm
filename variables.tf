variable "vmname" {
  description = "The name of the virtual machine used to deploy the vms"
  default     = "terraformvm"
}

variable "vmnamesuffix" {
  description = "vmname suffix after numbered index coming from instance variable"
  default     = ""
}

variable "vmnameliteral" {
  description = "vmname without any suffix or Prefix, only to be used for single instances"
  default     = ""
}

variable "vmtemp" {
  description = "Name of the template available in the vSphere"
}

variable "instances" {
  description = "number of instances you want deploy from the template"
  default     = 1
}

variable "cpu_number" {
  description = "number of CPU (core per CPU) for the VM"
  default     = 2
}

variable "ram_size" {
  description = "VM RAM size in megabytes"
  default     = 4096
}

variable "network_cards" {
  description = ""
  type        = list(string)
}

variable "ipv4" {
  description = "host(VM) IP address in map format, support more than one IP. Should correspond to number of instances"
  type        = "map"
}

variable "ipv4submask" {
  description = "ipv4 Subnet mask"
  type        = "list"
  default     = ["24"]
}

variable "dc" {
  description = "Name of the datacenter you want to deploy the VM to"
}

variable "vmrp" {
  description = "Cluster resource pool that VM will be deployed to. you use following to choose default pool in the cluster (esxi1) or (Cluster)/Resources"
}

variable "ds_cluster" {
  description = "Datastore cluster to deploy the VM."
  default     = ""
}

variable "datastore" {
  description = "Datastore to deploy the VM."
  default     = ""
}


variable "vmfolder" {
  description = "The path to the folder to put this virtual machine in, relative to the datacenter that the resource pool is in."
  default     = null
}

variable "vmgateway" {
  description = "VM gateway to set during provisioning"
  default     = null
}

variable "vmdns" {
  type    = list(string)
  default = null
}

#Global Customization Variables
variable "tags" {
  description = "The names of any tags to attach to this resource. They shoud already exist"
  type        = map
  default     = null
}

variable "custom_attributes" {
  description = "Map of custom attribute ids to attribute value strings to set for virtual machine."
  type        = map
  default     = null
}

variable "extra_config" {
  description = "Extra configuration data for this virtual machine. Can be used to supply advanced parameters not normally in configuration, such as instance metadata.'disk.enableUUID', 'True'"
  type        = map
  default     = null
}

variable "annotation" {
  description = "A user-provided description of the virtual machine. The default is no annotation."
  default     = null
}


variable "linked_clone" {
  description = "Clone this virtual machine from a snapshot. Templates must have a single snapshot only in order to be eligible."
  default     = "false"
}

variable "timeout" {
  description = "The timeout, in minutes, to wait for the virtual machine clone to complete."
  type        = number
  default     = 30
}

variable "dns_suffix_list" {
  description = "A list of DNS search domains to add to the DNS configuration on the virtual machine."
  type        = list(string)
  default     = null
}

variable "firmware" {
  description = "The firmware interface to use on the virtual machine. Can be one of bios or EFI."
  default     = "bios"
}

variable "num_cores_per_socket" {
  description = "The number of cores to distribute among the CPUs in this virtual machine. If specified, the value supplied to num_cpus must be evenly divisible by this value."
  type        = number
  default     = 1
}

variable "cpu_hot_add_enabled" {
  description = "Allow CPUs to be added to this virtual machine while it is running."
  default     = null
}

variable "cpu_hot_remove_enabled" {
  description = "Allow CPUs to be removed to this virtual machine while it is running."
  default     = null
}

variable "memory_hot_add_enabled" {
  description = "Allow memory to be added to this virtual machine while it is running."
  default     = null
}

variable "data_disk_size_gb" {
  description = "Storage data disk size size"
  type        = "list"
  default     = []
}

variable "thin_provisioned" {
  description = "If true, this disk is thin provisioned, with space for the file being allocated on an as-needed basis."
  type        = "list"
  default     = null
}

variable "eagerly_scrub" {
  description = "if set to true, the disk space is zeroed out on VM creation. This will delay the creation of the disk or virtual machine. Cannot be set to true when thin_provisioned is true."
  type        = "list"
  default     = null
}

variable "enable_disk_uuid" {
  description = "Expose the UUIDs of attached virtual disks to the virtual machine, allowing access to them in the guest."
  default     = null
}


#Linux Customization Variables
variable "hw_clock_utc" {
  description = "Tells the operating system that the hardware clock is set to UTC"
  default     = "true"
}

variable "vmdomain" {
  description = "default VM domain for linux guest customization"
  default     = "Development.com"
}


#Windows Customization Variables
variable "is_windows_image" {
  description = "Boolean flag to notify when the custom image is windows based."
  default     = "false"
}

variable "local_adminpass" {
  description = "The administrator password for this virtual machine.(Required) when using join_windomain option"
  default     = null
}

variable "workgroup" {
  description = "The workgroup name for this virtual machine. One of this or join_domain must be included."
  default     = null
}


variable "windomain" {
  description = "The domain to join for this virtual machine. One of this or workgroup must be included."
  default     = null
}

variable "domain_admin_user" {
  description = "Domain admin user to join the server to AD.(Required) when using join_windomain option"
  default     = null
}

variable "domain_admin_password" {
  description = "Doamin User pssword to join the server to AD.(Required) when using join_windomain option"
  default     = null
}

variable "orgname" {
  description = "Organization name for when joining windows server to AD"
  default     = null
}

variable "auto_logon" {
  description = " Specifies whether or not the VM automatically logs on as Administrator. Default: false"
  default     = null
}

variable "auto_logon_count" {
  description = "Specifies how many times the VM should auto-logon the Administrator account when auto_logon is true. This should be set accordingly to ensure that all of your commands that run in run_once_command_list can log in to run"
  default     = null
}

variable "time_zone" {
  description = "The new time zone for the virtual machine. This is a numeric, sysprep-dictated, timezone code."
  default     = null
}

variable "run_once" {
  description = "List of Comamnd to run during first logon (Automatic login set to 1)"
  type        = list(string)
  default     = null
}

variable "productkey" {
  description = "Product key to be used during windows customization."
  default     = null
}

variable "full_name" {
  description = "The full name of the user of this virtual machine. This populates the user field in the general Windows system information. Default - Administrator"
  default     = null
}
