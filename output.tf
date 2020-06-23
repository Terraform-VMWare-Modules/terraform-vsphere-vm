output "DC_ID" {
  description = "id of vSphere Datacenter"
  value       = data.vsphere_datacenter.dc.id
}

output "ResPool_ID" {
  description = "Resource Pool id"
  value       = data.vsphere_resource_pool.pool.id
}

output "Windows-VM" {
  description = "VM Names"
  value       = vsphere_virtual_machine.Windows.*.name
}

output "Windows-ip" {
  description = "default ip address of the deployed VM"
  value       = vsphere_virtual_machine.Windows.*.default_ip_address
}

output "Windows-guest-ip" {
  description = "all the registered ip address of the VM"
  value       = vsphere_virtual_machine.Windows.*.guest_ip_addresses
}

output "Windows-uuid" {
  description = "UUID of the VM in vSphere"
  value       = vsphere_virtual_machine.Windows.*.uuid
}

output "Linux-VM" {
  description = "VM Names"
  value       = vsphere_virtual_machine.Linux.*.name
}

output "Linux-ip" {
  description = "default ip address of the deployed VM"
  value       = vsphere_virtual_machine.Linux.*.default_ip_address
}

output "Linux-guest-ip" {
  description = "all the registered ip address of the VM"
  value       = vsphere_virtual_machine.Linux.*.guest_ip_addresses
}

output "Linux-uuid" {
  description = "UUID of the VM in vSphere"
  value       = vsphere_virtual_machine.Linux.*.uuid
}
