variable "vm" {
  type = map(object({
    vmname           = string
    vmtemp           = string
    dc               = string
    vmrp             = string
    datastore        = string
    is_windows_image = bool
    instances        = number
    network          = map(list(string))
    dns_servers      = list(string)
  }))
}

module "example-server-basic" {
  source           = "../"
  for_each         = var.vm
  vmtemp           = each.value.vmtemp
  is_windows_image = each.value.is_windows_image
  instances        = each.value.instances
  vmname           = each.value.vmname
  vmrp             = each.value.vmrp
  network          = each.value.network
  dc               = each.value.dc
  datastore        = each.value.datastore
}
