# Terraform vSphere Module

![Terraform Version](https://img.shields.io/badge/Terraform-0.13.5-green.svg) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/Terraform-VMWare-Modules/vm/vsphere/) [![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](https://github.com/Terraform-VMWare-Modules/terraform-vsphere-vm/releases) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

For Virtual Machine Provisioning with (Linux/Windows) customization. Based on Terraform v0.13, this module include most of the advance features that are available in the resource `vsphere_virtual_machine`.

## Deploys (Single/Multiple) Virtual Machines to your vSphere environment

This Terraform module deploys single or multiple virtual machines of type (Linux/Windows) with following features:

- Ability to specify Linux or Windows VM customization.
- Ability to add multiple network cards for the VM   
- Ability to assign tags and custom variables.
- Ability to configure advance features for the vm.
- Ability to deploy either a datastore or a datastore cluster.
  - Add extra data disk (up to 15) to the VM.
  - Different datastores for data disks (datastore_id).
  - Different scsi_controllers per disk, including data disks.
- Ability to define depend on using variable vm_depends_on & tag_depends_on

> Note: For module to work it needs number of required variables corresponding to an existing resources in vSphere. Please refer to variable section for the list of required variables.

## Getting started

Following example contains the bare minimum options to be configured for (Linux/Windows) VM deployment. You can choose between windows and linux customization by simply using the ´is_windows_image´ boolean switch.

You can also download the entire module and use your own predefined variables to map your entire vSphere environment and use it within this module.

__Create a main.tf file and copy the following code. fill the required data and run terraform plan.__

```hcl

# Configure the VMware vSphere Provider
provider "vsphere" {
  user           = "fill"
  password       = "fill"
  vsphere_server = "fill" 

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

# Deploy 2 linux VMs
module "example-server-linuxvm" {
  source        = "Terraform-VMWare-Modules/vm/vsphere"
  version       = "X.X.X"
  vmtemp        = "VM Template Name (Should Alrerady exist)"
  instances     = 2
  vmname        = "example-server-linux"
  vmrp          = "esxi/Resources - or name of a resource pool"
  network = {
    "Name of the Port Group in vSphere" = ["10.13.113.2", "10.13.113.3"] # To use DHCP create Empty list ["",""]
  }
  vmgateway         = "10.13.113.1"
  dc        = "Datacenter"
  datastore = "Data Store name(use datastore_cluster for datastore cluster)"
}

```

## Advance Usage

There are number of switches defined in the module, where you can use to enable different features for VM provisioning.

- You can use `is_windows_image = true` to set the customization type to Windows (By default it is set to Linux customization)
- You can use `windomain = "somedomain.com"` to join a windows server to AD domain.
  - Requires following additional variables
    - `domainuser` Domain account with necessary privileges to join a computer to the domain.
    - `domainpass` Domain user password.
    - `is_windows_image` needs to be set to `true` to force the module to use Windows customization.

> Note: When deploying a windows server in WorkGroup, we recommend to keep the Local Admin password set to its default and change it later via an script. Unfortunately Terraform redeploy the entire server if you change the local admin password within your code.

Below is an example of windows deployment with some of the available feature sets. For complete list of available features please refer to [variable.tf](https://github.com/Terraform-VMWare-Modules/terraform-vsphere-vm/blob/master/variables.tf)

```hcl
module "example-server-windowsvm-advanced" {
  source                 = "Terraform-VMWare-Modules/vm/vsphere"
  version                = "X.X.X"
  dc                     = "Datacenter"
  vmrp                   = "cluster/Resources" #Works with ESXi/Resources
  vmfolder               = "Cattle"
  datastore_cluster      = "Datastore Cluster" #You can use datastore variable instead
  vmtemp                 = "TemplateName"
  instances              = 2
  vmname                 = "AdvancedVM"
  vmdomain               = "somedomain.com"
  network = {
    "Name of the Port Group in vSphere" = ["10.13.113.2", "10.13.113.3"] # To use DHCP create Empty list ["",""]
    "Second Network Card"       = ["", ""]
  }
  ipv4submask            = ["24", "8"]
  network_type              = ["vmxnet3", "vmxnet3"]
  tags = {
    "terraform-test-category" = "terraform-test-tag"
  }
  data_disk = {
    disk1 = {
      size_gb                   = 30,
      thin_provisioned          = false,
      data_disk_scsi_controller = 0,
    },
    disk2 = {
      size_gb                   = 70,
      thin_provisioned          = true,
      data_disk_scsi_controller = 1,
      datastore_id              = "datastore-90679"
    }
  }
  scsi_bus_sharing          = "physicalSharing" // The modes are physicalSharing, virtualSharing, and noSharing
  scsi_type                 = "lsilogic" // Other acceptable value "pvscsi"
  scsi_controller           = 0 // This will assign OS disk to controller 0
  vmdns             = ["192.168.0.2", "192.168.0.1"]
  vmgateway         = "192.168.0.1"
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

## Contributing

This module is the work of many contributors. We appreciate your help!

To contribute, please read the [contribution guidelines](https://github.com/Terraform-VMWare-Modules/terraform-vsphere-vm/blob/master/CONTRIBUTING.md)

## Authors

Originally created by [Arman Keyoumarsi](https://github.com/Arman-Keyoumarsi)

## License

[MIT](LICENSE)
