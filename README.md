# Terraform vSphere Module

For Virtual Machine Provisioning with (Linux/Windows) customization.

## Deploys (Single/Multiple) Virtual Machines to your vSphere environment

This Terraform module deploys single or multiple virtual machines of type (Linux/Windows) with following features:

* Ability to specify Linux or Windows VM customization.
* Ability to add extra data disk to the VM.
* Ability to deploy Multiple instances.
* Ability to set IP and Gateway configuration for the VM.
* Ability to choose vSphere resource pool or fall back to Cluster/ESXi root resource pool.
* Ability to deploy Windows images to WorkGroup or Domain.
* Ability to output VM names and IPs per module.

> Note: For module to work it needs number of required variables corresponding to an existing resources in vSphere. Please refer to variable section for the list of required variables.

## Usage

Following example contains the bare minimum options to be configured for (Linux/Windows) VM deployment. You can choose between windows and linux customization by simply using the ´is_windows_image´ boolean switch.

You can also download the entire module and use your own predefined variables to map your entire vSphere environment and use it within this module.

```hcl
module "example-server-linuxvm-withdatadisk" {
  source            = "Terraform-VMWare-Modules/vm/vsphere"
  version           = "0.9.2"
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

module "example-server-windowsvm-withdatadisk" {
  source            = "Terraform-VMWare-Modules/vm/vsphere"
  version           = "0.9.2"
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

> Note: When deploying a windows server in WorkGroup, we recommend to keep the Local Admin password set to its default and change it later via an script. Unfortunately Terraform redeploy the entire server if you change the local admin password within your code.

## Advance Usage

There are number of switches defined in the module, where you can use to enable different features for VM provisioning.

### Main Feature Switches

* You can use `is_windows_image = "true"` to set the customization type to Windows (By default it is set to Linux customization)
* You can use `data_disk = "true"` to add one additional disk (Supported in both Linux and Windows deployment)
  * By default it is set to 20GB. You can modify it by using `data_disk_size_gb` variable.
* You can use `join_windomain = "true"` to join a windows server to AD domain.
  * Requires following additional variables
    * `domainuser` Domain account with necessary privileges to join a computer to the domain.
    * `domainpass` Domain user password.
    * `is_windows_image` needs to be set to `true` to force the module to use Windows customization.

Below is an example of windows deployment with all available feature sets.

```hcl
module "example-server-windowsvm-withdatadisk-domain" {
  source            = "Terraform-VMWare-Modules/vm/vsphere"
  version           = "0.9.2"
  vmtemp            = "TemplateName"
  instances         = 1
  vmname            = "example-server-windows"
  vmrp              = "esxi/Resources"  
  vlan              = "Name of the VLAN in vSphere"
  is_windows_image  = "true"
  data_disk         = "true"
  data_disk_size_gb = 40
  join_windomain    = "true"
  domainpass        = "Domain Password"
  domainuser        = "Domain User"
  run_once          = ["echo Hello World"]
  productkey        = "WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY"
  dc                = "Datacenter"
  ds_cluster        = "Data Store Cluster name"
  ipaddress         = ["10.0.0.13"]
  vmdns             = ["1.1.1.1", "8.8.8.8"]
  vmgateway         = "10.0.0.1"
  winadminpass      = "Str0ngP@ssw0rd!"
}

output "vmnames" {
  value = "${module.example-server-windowsvm-withdatadisk-domain.vm_name}"
}

output "vmnameswip" {
  value = "${module.example-server-windowsvm-withdatadisk-domain.vm_ip}"
}

```

## Authors

Originally created by [Arman Keyoumarsi](https://github.com/Arman-Keyoumarsi)

## License

[MIT](LICENSE)