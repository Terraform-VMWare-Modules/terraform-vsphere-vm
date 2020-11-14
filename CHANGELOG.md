# ChanegLog

## v2.0.0
__New Variables__
```hcl
variable "network" {
  description = "Define PortGroup and IPs for each VM"
  type        = map(list(string))
  default     = {}
}
variable "data_disk" {
  description = "Storage data disk parameter, example"
  type        = map(map(string))
  default     = {}
}
```
__Removed varsiables__

```hcl
#Network Section
variable "network_cards" {
  description = ""
  type        = list(string)
  default     = null
}

variable "ipv4" {
  description = "host(VM) IP address in map format, support more than one IP. Should correspond to number of instances."
  type        = map
  default     = {}
}

#Data Disk Section
data "vsphere_datastore" "data_disk_datastore" {
  for_each      = toset(var.data_disk_datastore)
  name          = each.key
  datacenter_id = data.vsphere_datacenter.dc.id
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
```
