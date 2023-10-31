# This workspace id to test the newly added functionality of the changes.
#
# Testing Tags
resource "vsphere_tag_category" "category" {
  name        = "terraform-test-category"
  cardinality = "SINGLE"
  description = "Managed by Terraform"

  associable_types = [
    "VirtualMachine",
    "Datastore",
  ]
}

resource "vsphere_tag" "tag" {
  name        = "terraform-test-tag"
  category_id = vsphere_tag_category.category.id
  description = "Managed by Terraform"
}
#to test naming convention
variable "env" {
  default = "dev"
}

#Do not add any new variables here unless it is sensitive
variable "vm" {
  type = map(object({
    vmname           = string
    vmtemp           = string
    dc               = string
    vmrp             = string
    vmfolder         = string
    datastore        = string
    is_windows_image = bool
    network          = map(list(string))
    vmgateway        = string
    dns_servers      = list(string)
  }))
}

#add the new added function/variables here
module "example-server-basic" {
  source           = "../../"
  for_each         = var.vm
  vmrp             = each.value.vmrp
  vmfolder         = each.value.vmfolder
  vmtemp           = each.value.vmtemp
  is_windows_image = each.value.is_windows_image
  network          = each.value.network
  vmgateway        = each.value.vmgateway
  dc               = each.value.dc
  datastore        = each.value.datastore
  #starting of static values
  instances      = 2
  vmstartcount   = 5
  vmnameformat   = "%03d${var.env}"
  domain         = "somedomain.com"
  fqdnvmname     = true
  vmname         = "terraform-sanitytest"
  annotation     = "Terraform Sanity Test"
  tag_depends_on = [vsphere_tag.tag.id]
  tags = {
    "terraform-test-category" = "terraform-test-tag",
  }
  data_disk = {
    disk1 = {
      size_gb                   = 30,
      thin_provisioned          = false,
      data_disk_scsi_controller = 0,
      storage_policy_id         = "ff45cc66-b624-4621-967f-1aef6437f568"
    },
    disk2 = {
      size_gb                   = 70,
      thin_provisioned          = true,
      data_disk_scsi_controller = 1,
      io_reservation            = 15
      io_share_level            = "custom"
      io_share_count            = 2000
    }
  }
  io_reservation     = [15]
  io_share_level     = ["custom"]
  io_share_count     = [2000]
  memory_share_level = "custom"
  memory_share_count = 2000
  cpu_share_level    = "custom"
  cpu_share_count    = 2000
  #ipv4submask        = ["28", "26"]
}

output "DC_ID" {
  value = tomap({
    for k, i in module.example-server-basic : k => i.DC_ID
  })
}

output "VM" {
  value = tomap({
    for k, i in module.example-server-basic : k => i.VM
  })
}
