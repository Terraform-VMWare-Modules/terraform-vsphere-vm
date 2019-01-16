output "DC_ID" {
  description = "id of vSphere Datacenter"
  value = "${data.vsphere_datacenter.dc.id}"
}
output "ResPool_ID" {
  description = "Resource Pool id"
  value = "${data.vsphere_resource_pool.pool.id}"
}
output "vm_name" {
  description = "VMs names deployed from all reources"
  value = ["${vsphere_virtual_machine.LinuxVM.*.name}"]
  value = ["${vsphere_virtual_machine.LinuxVM-withDataDisk.*.name}"]
  value = ["${vsphere_virtual_machine.WindowsVM.*.name}"]
  value = ["${vsphere_virtual_machine.WindowsVM-withDataDisk.*.name}"]
  value = ["${vsphere_virtual_machine.WindowsVM-Domain.*.name}"]
  value = ["${vsphere_virtual_machine.WindowsVM-withDataDisk-Domain.*.name}"]
}
output "vm_ip" {
  description = "VMs IPs deployed from reource LinuxVM"
  value = ["${vsphere_virtual_machine.LinuxVM.*.default_ip_address}"]
  value = ["${vsphere_virtual_machine.LinuxVM-withDataDisk.*.default_ip_address}"]
  value = ["${vsphere_virtual_machine.WindowsVM.*.default_ip_address}"]
  value = ["${vsphere_virtual_machine.WindowsVM-withDataDisk.*.default_ip_address}"]
  value = ["${vsphere_virtual_machine.WindowsVM-Domain.*.default_ip_address}"]
  value = ["${vsphere_virtual_machine.WindowsVM-withDataDisk-Domain.*.default_ip_address}"]
}