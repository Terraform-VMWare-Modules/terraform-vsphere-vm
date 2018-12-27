# Terraform vSphere Module

For Virtual Machine Provisioning with (Linux/Windows) customization.

## Deploys (Single/Multiple) Virtual Machines to your vSphere environment

This Terraform module deploys single or multiple virtual machines of type (Linux/Windows) with following features:

* Ability to specify Linux or Windows VM customization.
* Ability to add extra data disk to the VM.
* Ability to deploy Multiple instances.
* Ability to set IP and Gateway configuration for the VM.
* Ability to choose vSphere resource pool or fall back to Cluster/ESXi root resource pool.

> Note: For module to work it needs number of required variables that need to correspond to an existing resources in vSphere. Please refer to variable section for the list of required variables.

## Usage

Following example contains the bare minimum options to be configured for the VM to be provisioned. You can choose between windows and linux customization by simply using the ´is_windows_image´ boolean switch.

You can also download the entire module and use your own predefined variables to map your entire vSphere environment and use it within this module.

```hcl
module "example-server-linux-withdatadisk" {
  source            = "Module Source"
  version           = "0.9.0"
  vmtemp            = "TemplateName"
  instances         = 1
  vmname            = "example-server-windows"
  vmrp              = "esxi/Resources"  
  vlan              = "Name of the VLAN in vSphere"
  data_disk         = "true"
  data_disk_size_gb = 20
  dc                = "Datacenter"
  ds_cluster        = "Data Store Cluster name"
}

module "example-server-windows-withdatadisk" {
  source            = "Module Source"
  version           = "0.9.0"
  vmtemp            = "TemplateName"
  instances         = 1
  vmname            = "example-server-windows"
  vmrp              = "esxi/Resources"  
  vlan              = "Name of the VLAN in vSphere"
  data_disk         = "true"
  data_disk_size_gb = 20
  is_windows_image  = "true"
  dc                = "Datacenter"
  ds_cluster        = "Data Store Cluster name"
  winadminpass      = "Str0ngP@ssw0rd!"
}
```
