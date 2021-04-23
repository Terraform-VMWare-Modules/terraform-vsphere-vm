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

variable "env" {
  default = "dev"
}

data "vsphere_storage_policy" "this" {
  name = "Test"
}

output "disk_id" {
  value = data.vsphere_storage_policy.this.id
}

variable "vm" {
  type = map(object({
    vmname           = string
    vmtemp           = string
    dc               = string
    vmrp             = string
    vmfolder         = string
    datastore        = string
    is_windows_image = bool
    tags             = map(string)
    instances        = number
    network          = map(list(string))
    vmgateway        = string
    dns_servers      = list(string)
    data_disk        = map(map(string))
  }))
}

module "example-server-basic" {
  source                     = "../../"
  for_each                   = var.vm
  vmnameformat               = "%03d${var.env}"
  template_storage_policy_id = [data.vsphere_storage_policy.this.id]
  tag_depends_on             = [vsphere_tag.tag.id]
  tags                       = each.value.tags
  vmtemp                     = each.value.vmtemp
  is_windows_image           = each.value.is_windows_image
  instances                  = each.value.instances
  vmname                     = each.value.vmname
  vmrp                       = each.value.vmrp
  vmfolder                   = each.value.vmfolder
  network                    = each.value.network
  vmgateway                  = each.value.vmgateway
  dc                         = each.value.dc
  datastore                  = each.value.datastore
  data_disk                  = each.value.data_disk
}

