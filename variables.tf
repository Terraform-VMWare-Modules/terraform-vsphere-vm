variable "vmname" {
  description = "The name of the virtual machine used to deploy the vms."
  default     = "terraformvm"
}

variable "vmnamesuffix" {
  description = "vmname suffix after numbered index coming from instance variable."
  default     = ""
}

variable "vmnameliteral" {
  description = "vmname without any suffix or Prefix, only to be used for single instances."
  default     = ""
}

variable "vmtemp" {
  description = "Name of the template available in the vSphere."
}

variable "instances" {
  description = "number of instances you want deploy from the template."
  default     = 1
}

variable "cpu_number" {
  description = "number of CPU (core per CPU) for the VM."
  default     = 2
}

variable "cpu_reservation" {
  description = "The amount of CPU (in MHz) that this virtual machine is guaranteed."
  default     = null
}


variable "ram_size" {
  description = "VM RAM size in megabytes."
  default     = 4096
}

variable "network_cards" {
  description = ""
  type        = list(string)
}

variable "ipv4" {
  description = "host(VM) IP address in map format, support more than one IP. Should correspond to number of instances."
  type        = map
}

variable "ipv4submask" {
  description = "ipv4 Subnet mask."
  type        = list
  default     = ["24"]
}

variable "dc" {
  description = "Name of the datacenter you want to deploy the VM to."
}

variable "vmrp" {
  description = "Cluster resource pool that VM will be deployed to. you use following to choose default pool in the cluster (esxi1) or (Cluster)/Resources."
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
  description = "VM gateway to set during provisioning."
  default     = null
}

variable "vmdns" {
  type    = list(string)
  default = null
}

#Global Customization Variables
variable "tags" {
  description = "The names of any tags to attach to this resource. They must already exist."
  type        = map
  default     = null
}

variable "tag_ids" {
  description = "The ids of any tags to attach to this resource. They must already exist."
  type        = list
  default     = null
}

variable "custom_attributes" {
  description = "Map of custom attribute ids to attribute value strings to set for virtual machine."
  type        = map
  default     = null
}

variable "extra_config" {
  description = "Extra configuration data for this virtual machine. Can be used to supply advanced parameters not normally in configuration, such as instance metadata.'disk.enableUUID', 'True'."
  type        = map
  default     = null
}

variable "annotation" {
  description = "A user-provided description of the virtual machine. The default is no annotation."
  default     = null
}


variable "linked_clone" {
  description = "Clone this virtual machine from a snapshot. Templates must have a single snapshot only in order to be eligible."
  default     = false
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
  type        = bool
  default     = null
}

variable "cpu_hot_remove_enabled" {
  description = "Allow CPUs to be removed to this virtual machine while it is running."
  type        = bool
  default     = null
}

variable "memory_hot_add_enabled" {
  description = "Allow memory to be added to this virtual machine while it is running."
  type        = bool
  default     = null
}

variable "memory_reservation" {
  description = "The amount of memory (in MB) that this virtual machine is guaranteed."
  default     = null
}

variable "disk_label" {
  description = "Storage data disk labels."
  type        = list
  default     = []
}

variable "data_disk_label" {
  description = "Storage data disk labels."
  type        = list
  default     = []
}

variable "data_disk_size_gb" {
  description = "List of Storage data disk size."
  type        = list
  default     = []
}

variable "disk_size_gb" {
  description = "List of disk sizes to override template disk size."
  type = list
  default = null
}

variable "disk_datastore" {
  description = "Define where the OS disk should be stored."
  type        = string
  default     = ""
}

variable "data_disk_datastore" {
  description = "Define where the data disk should be stored, should be equal to number of defined data disks."
  type        = list
  default     = []
  # validation {
  #   condition     = length(var.disk_datastore) == 0 || length(var.disk_datastore) == length(var.data_disk_size_gb)
  #       error_message = "The list of disk datastore must be equal in length to disk_size_gb"
  # }
}

variable "data_disk_scsi_controller" {
  description = "scsi_controller number for the data disk, should be equal to number of defined data disk."
  type        = list
  default     = []
  # validation {
  #   condition     = max(var.data_disk_scsi_controller...) < 4 && max(var.data_disk_scsi_controller...) > -1
  #       error_message = "The scsi_controller must be between 0 and 3"
  # }
}

variable "scsi_bus_sharing" {
  description = "scsi_bus_sharing mode, acceptable values physicalSharing,virtualSharing,noSharing."
  type        = string
  default     = null
}

variable "scsi_type" {
  description = "scsi_controller type, acceptable values lsilogic,pvscsi."
  type        = string
  default     = ""
}

variable "scsi_controller" {
  description = "scsi_controller number for the main OS disk."
  type        = number
  default     = 0
  # validation {
  #   condition     = var.scsi_controller < 4 && var.scsi_controller > -1
  #       error_message = "The scsi_controller must be between 0 and 3"
  # }
}

variable "thin_provisioned" {
  description = "If true, this disk is thin provisioned, with space for the file being allocated on an as-needed basis."
  type        = list
  default     = null
}

variable "eagerly_scrub" {
  description = "if set to true, the disk space is zeroed out on VM creation. This will delay the creation of the disk or virtual machine. Cannot be set to true when thin_provisioned is true."
  type        = list
  default     = null
}

variable "enable_disk_uuid" {
  description = "Expose the UUIDs of attached virtual disks to the virtual machine, allowing access to them in the guest."
  type        = bool
  default     = null
}

variable "network_type" {
  description = "Define network type for each network interface."
  type        = list
  default     = null
}

#Linux Customization Variables
variable "hw_clock_utc" {
  description = "Tells the operating system that the hardware clock is set to UTC."
  type        = bool
  default     = true
}

variable "vmdomain" {
  description = "default VM domain for linux guest customization."
  default     = "Development.com"
}


#Windows Customization Variables
variable "is_windows_image" {
  description = "Boolean flag to notify when the custom image is windows based."
  type        = bool
  default     = false
}

variable "local_adminpass" {
  description = "The administrator password for this virtual machine.(Required) when using join_windomain option."
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
  description = "Domain admin user to join the server to AD.(Required) when using join_windomain option."
  default     = null
}

variable "domain_admin_password" {
  description = "Doamin User pssword to join the server to AD.(Required) when using join_windomain option."
  default     = null
}

variable "orgname" {
  description = "Organization name for when joining windows server to AD."
  default     = null
}

variable "auto_logon" {
  description = " Specifies whether or not the VM automatically logs on as Administrator. Default: false."
  type = bool
  default     = null
}

variable "auto_logon_count" {
  description = "Specifies how many times the VM should auto-logon the Administrator account when auto_logon is true. This should be set accordingly to ensure that all of your commands that run in run_once_command_list can log in to run."
  default     = null
}

variable "time_zone" {
  description = "The new time zone for the virtual machine. This is a numeric, sysprep-dictated, timezone code."
  default     = null
}

variable "run_once" {
  description = "List of Comamnd to run during first logon (Automatic login set to 1)."
  type        = list(string)
  default     = null
}

variable "productkey" {
  description = "Product key to be used during windows customization."
  default     = null
}

variable "full_name" {
  description = "The full name of the user of this virtual machine. This populates the user field in the general Windows system information. Default - Administrator."
  default     = null
}

variable "wait_for_guest_net_routable" {
  description = "Controls whether or not the guest network waiter waits for a routable address. When false, the waiter does not wait for a default gateway, nor are IP addresses checked against any discovered default gateways as part of its success criteria. This property is ignored if the wait_for_guest_ip_timeout waiter is used."
  type        = bool
  default     = true
}

variable "wait_for_guest_ip_timeout" {
  description = "The amount of time, in minutes, to wait for an available guest IP address on this virtual machine. This should only be used if your version of VMware Tools does not allow the wait_for_guest_net_timeout waiter to be used. A value less than 1 disables the waiter."
  type        = number
  default     = 0
}

variable "wait_for_guest_net_timeout" {
  description = "The amount of time, in minutes, to wait for an available IP address on this virtual machine's NICs. Older versions of VMware Tools do not populate this property. In those cases, this waiter can be disabled and the wait_for_guest_ip_timeout waiter can be used instead. A value less than 1 disables the waiter."
  type        = number
  default     = 5
}

variable "ignored_guest_ips" {
  description = "List of IP addresses and CIDR networks to ignore while waiting for an available IP address using either of the waiters. Any IP addresses in this list will be ignored if they show up so that the waiter will continue to wait for a real IP address."
  type        = list(string)
  default     = []
}

variable "vm_depends_on" {
  description = "Add any external depend on module here like vm_depends_on = [module.fw_core01.firewall]."
  type        = any
  default     = null
}

variable "tag_depends_on" {
  description = "Add any external depend on module here like tag_depends_on = [vsphere_tag.foo.id]."
  type        = any
  default     = null
}

variable "hv_mode" {
  description = "The (non-nested) hardware virtualization setting for this virtual machine. Can be one of hvAuto, hvOn, or hvOff."
  type        = string
  default     = null
}

variable "ept_rvi_mode" {
  description = "The EPT/RVI (hardware memory virtualization) setting for this virtual machine."
  type        = string
  default     = null
}

variable "nested_hv_enabled" {
  description = "Enable nested hardware virtualization on this virtual machine, facilitating nested virtualization in the guest."
  type        = bool
  default     = null
}

variable "enable_logging" {
  description = "Enable logging of virtual machine events to a log file stored in the virtual machine directory."
  type        = bool
  default     = null
}

variable "cpu_performance_counters_enabled" {
  description = "Enable CPU performance counters on this virtual machine."
  type        = bool
  default     = null
}

variable "swap_placement_policy" {
  description = "The swap file placement policy for this virtual machine. Can be one of inherit, hostLocal, or vmDirectory."
  type        = string
  default     = null
}

variable "latency_sensitivity" {
  description = "Controls the scheduling delay of the virtual machine. Use a higher sensitivity for applications that require lower latency, such as VOIP, media player applications, or applications that require frequent access to mouse or keyboard devices.Can be one of low, normal, medium, or high."
  type        = string
  default     = null
}

variable "shutdown_wait_timeout" {
  description = "The amount of time, in minutes, to wait for a graceful guest shutdown when making necessary updates to the virtual machine. If force_power_off is set to true, the VM will be force powered-off after this timeout, otherwise an error is returned."
  type        = string
  default     = null
}

variable "migrate_wait_timeout" {
  description = "The amount of time, in minutes, to wait for a graceful guest shutdown when making necessary updates to the virtual machine. If force_power_off is set to true, the VM will be force powered-off after this timeout, otherwise an error is returned."
  type        = string
  default     = null
}

variable "force_power_off" {
  description = "If a guest shutdown failed or timed out while updating or destroying (see shutdown_wait_timeout), force the power-off of the virtual machine."
  type        = bool
  default     = null
}