# Terraform vSphere Module

![Terraform Version](https://img.shields.io/badge/Terraform-0.12.6-green.svg) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/Terraform-VMWare-Modules/vm/vsphere/) [![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](https://github.com/Terraform-VMWare-Modules/terraform-vsphere-vm/releases) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

For Virtual Machine Provisioning with (Linux/Windows) customization. Thanks to the new enhancements introduced in Terraform v0.12.6 this module include most of the advance features that are available in the resource `vsphere_virtual_machine`.

## Deploys (Single/Multiple) Virtual Machines to your vSphere environment

This Terraform module deploys single or multiple virtual machines of type (Linux/Windows) with following features:

- Ability to specify Linux or Windows VM customization.
- Ability to add extra data disk (up to 15) to the VM.
- Ability to deploy Multiple instances.
- Ability to set IP and Gateway configuration for the VM.
- Ability to add multiple network cards for the VM
- Ability to choose vSphere resource pool or fall back to Cluster/ESXi root resource pool.
- Ability to deploy Windows images to WorkGroup or Domain.
- Ability to output VM names and IPs per module.
- Ability assign tags and custom variables.
- Ability to configure advance features for the vm.
- Ability to deploy either a datastore or a datastore cluster.
- Ability to enable cpu and memory hot plug features for the VM.
- Ability to enable cpu and memory reservations for the VM.
- Ability to define different datastores for data disks.
- Ability to define different scsi_controllers per disk, including data disks.
- Ability to define network type per interface and disk label per attached disk.
- Ability to define depend on using variable vm_depends_on

> Note: For module to work it needs number of required variables corresponding to an existing resources in vSphere. Please refer to variable section for the list of required variables.

## Usage

Following example contains the bare minimum options to be configured for (Linux/Windows) VM deployment. You can choose between windows and linux customization by simply using the ´is_windows_image´ boolean switch.

You can also download the entire module and use your own predefined variables to map your entire vSphere environment and use it within this module.

```hcl
module "example-server-linuxvm" {
  source        = "Terraform-VMWare-Modules/vm/vsphere"
  version       = "X.X.X"
  vmtemp        = "TemplateName"
  instances     = 1
  vmname        = "example-server-linux"
  vmrp          = "esxi/Resources"
  network_cards = ["Name of the Port Group in vSphere"]
  ipv4 = {
    "Name of the Port Group in vSphere" = ["10.0.0.1"] # To use DHCP create Empty list for each instance
  }
  dc        = "Datacenter"
  datastore = "Data Store name(use ds_cluster for datastore cluster)"
}

module "example-server-windowsvm" {
  source           = "Terraform-VMWare-Modules/vm/vsphere"
  version          = "X.X.X"
  vmtemp           = "TemplateName"
  is_windows_image = true
  instances        = 1
  vmname           = "example-server-windows"
  vmrp             = "esxi/Resources"
  network_cards    = ["Name of the Port Group in vSphere"]
  ipv4 = {
    "Name of the Port Group in vSphere" = ["10.0.0.1"] # To use DHCP create Empty list for each instance
  }
  dc        = "Datacenter"
  datastore = "Data Store name(use ds_cluster for datastore cluster)"
}
```

> Note: When deploying a windows server in WorkGroup, we recommend to keep the Local Admin password set to its default and change it later via an script. Unfortunately Terraform redeploy the entire server if you change the local admin password within your code.

## Advance Usage

There are number of switches defined in the module, where you can use to enable different features for VM provisioning.

### Main Feature Switches

- You can use `is_windows_image = true` to set the customization type to Windows (By default it is set to Linux customization)
- You can use `data_disk_size_gb = [20,30]` to add additional data disks (Supported in both Linux and Windows deployment)
  - Above switch will create two additional disk of capacity 10 and 30gb for the VM.
  - You can include `thin_provisioned` switch to define disk type for each additional disk.
- You can use `windomain = "somedomain.com"` to join a windows server to AD domain.
  - Requires following additional variables
    - `domainuser` Domain account with necessary privileges to join a computer to the domain.
    - `domainpass` Domain user password.
    - `is_windows_image` needs to be set to `true` to force the module to use Windows customization.

Below is an example of windows deployment with some of the available feature sets.

```hcl
module "example-server-windowsvm-advanced" {
  source                 = "Terraform-VMWare-Modules/vm/vsphere"
  version                = "X.X.X"
  dc                     = "Datacenter"
  vmrp                   = "cluster/Resources" #Works with ESXi/Resources
  vmfolder               = "Cattle"
  ds_cluster             = "Datastore Cluster" #You can use datastore variable instead
  vmtemp                 = "TemplateName"
  instances              = 2
  cpu_number             = 2
  ram_size               = 2096
  cpu_reservation        = 2000
  memory_reservation     = 2000
  cpu_hot_add_enabled    = true
  cpu_hot_remove_enabled = true
  memory_hot_add_enabled = true
  vmname                 = "AdvancedVM"
  vmdomain               = "somedomain.com"
  network_cards          = ["VM Network", "test-network"] #Assign multiple cards
  network_type              = ["vmxnet3", "vmxnet3"]
  ipv4submask            = ["24", "8"]
  ipv4 = { #assign IPs per card
    "VM Network" = ["192.168.0.4", ""] // Here the first instance will use Static Ip and Second DHCP
    "test"       = ["", "192.168.0.3"]
  }
  data_disk_size_gb = [10, 5] // Aditional Disk to be used
  thin_provisioned  = [true, false]
  disk_label                = ["tpl-disk-1"]
  data_disk_label           = ["label1", "label2"]
  disk_datastore             = "vsanDatastore" // This will store Template disk in the defined disk_datastore
  data_disk_datastore        = ["vsanDatastore", "nfsDatastore"] // Datastores for additional data disks
  scsi_bus_sharing          = "physicalSharing" // The modes are physicalSharing, virtualSharing, and noSharing
  scsi_type                 = "lsilogic" // Other acceptable value "pvscsi"
  scsi_controller           = 0 // This will assign OS disk to controller 0
  data_disk_scsi_controller = [0, 1] // This will create a new controller and assign second data disk to controller 1
  vmdns             = ["192.168.0.2", "192.168.0.1"]
  vmgateway         = "192.168.0.1"
  tags = {
    "terraform-test-category"    = "terraform-test-tag"
    "terraform-test-category-02" = "terraform-test-tag-02"
  }
  enable_disk_uuid = true
  auto_logon       = true
  run_once         = ["command01", "command02"] // You can also run Powershell commands
  orgname          = "Terraform-Module"
  workgroup        = "Module-Test"
  is_windows_image = true
  firmware         = "efi"
  local_adminpass  = "Password@Strong"
}

output "vmnames" {
  value = "${module.example-server-windowsvm-advanced.Windows-VM}"
}

output "vmnameswip" {
  value = "${module.example-server-windowsvm-advanced.Windows-ip}"
}

```

## Authors

Originally created by [Arman Keyoumarsi](https://github.com/Arman-Keyoumarsi)

## License

[MIT](LICENSE)
