output "DC_ID" {
  description = "id of vSphere Datacenter"
  value = "${data.vsphere_datacenter.dc.id}"
}

output "ResPool_ID" {
  description = "Resource Pool id"
  value = "${data.vsphere_resource_pool.pool.id}"
}