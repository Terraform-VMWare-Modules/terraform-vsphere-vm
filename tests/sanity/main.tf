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

variable "vm" {
  type = map(object({
    vmname             = string
    vmtemp             = string
    dc                 = string
    vmrp               = string
    vmfolder           = string
    datastore          = string
    is_windows_image   = bool
    tags               = map(string)
    instances          = number
    network            = map(list(string))
    vmgateway          = string
    dns_servers        = list(string)
    data_disk          = map(map(string))
    cpu_share_level    = string
    cpu_share_count    = number
    memory_share_level = string
    memory_share_count = number
    io_reservation     = list(number)
    io_share_level = list(string)
    io_share_count = list(number)
  }))
}

module "example-server-basic" {
  source           = "../../"
  for_each         = var.vm
  vmnameformat     = "%03d${var.env}"
  tag_depends_on   = [vsphere_tag.tag.id]
  tags             = each.value.tags
  vmtemp           = each.value.vmtemp
  is_windows_image = each.value.is_windows_image
  instances        = each.value.instances
  vmname           = each.value.vmname
  vmrp             = each.value.vmrp
  vmfolder         = each.value.vmfolder
  network          = each.value.network
  vmgateway        = each.value.vmgateway
  dc               = each.value.dc
  datastore        = each.value.datastore
  data_disk        = each.value.data_disk
  cpu_share_level  = each.value.cpu_share_level
  # cpu_share_count    = each.value.cpu_share_level == "custom" ? each.value.cpu_share_count : null
  # memory_share_level = each.value.memory_share_level
  # memory_share_count = each.value.memory_share_level == "custom" ? each.value.memory_share_count : null
  # io_share_level     = each.value.io_share_level
  # io_share_count     = each.value.io_share_level == "custom" ? each.value.io_share_count : null
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
