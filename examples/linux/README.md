# Terraform vSphere LinuxVM example

For Virtual Machine Provisioning with Linux customization.

> Note: For module to work it needs number of required variables corresponding to an existing resources in vSphere. Please refer to variable section for the list of required variables.

## Usage

Following example contains the bare minimum options to be configured for the Linux VM deployment.

### Simple Linux VM deployment

```hcl
module "example-server-linuxvm" {
  source            = "Terraform-VMWare-Modules/vm/vsphere"
  version           = "1.1.0"
  vmtemp            = "TemplateName"
  instances         = 1
  vmname            = "example-server-windows"
  vmrp              = "esxi/Resources"
  network_cards     = ["Name of the Port Group in vSphere"]
  ipv4 = {
    "Name of the Port Group in vSphere" = ["10.0.0.1"] # To use DHCP create Empty list for each instance
  }
  dc                = "Datacenter"
  datastore         = "Data Store name(use ds_cluster for datastore cluster)"
}
```

### Example of Advanced Linux VM Customization

Below example will deploy 2 instance of a virtual machine from a linux template. The virtual machines are configured to use 2 network cards with 2 additional disk.

> You add up to 15 additional disk for each VM

```hcl
module "example-server-linuxvm-withdatadisk" {
  source                 = "Terraform-VMWare-Modules/vm/vsphere"
  version                = "1.1.0"
  dc                     = "Datacenter"
  vmrp                   = "cluster/Resources"
  vmfolder               = "Cattle"
  ds_cluster             = "Datastore Cluster"
  vmtemp                 = "TemplateName"
  instances              = 2
  cpu_number             = 2
  ram_size               = 2096
  cpu_hot_add_enabled    = "true"
  cpu_hot_remove_enabled = "true"
  memory_hot_add_enabled = "true"
  vmname                 = "AdvancedVM"
  vmdomain               = "somedomain.com"
  network_cards          = ["VM Network", "test-network"]
  ipv4submask            = ["24", "8"]
  ipv4 = {
    "VM Network" = ["192.168.0.4", ""] // Here the first instance will use Static Ip and Second set to DHCP
    "test"       = ["", "192.168.0.3"]
  }
  data_disk_size_gb = [10, 5] // Aditional Disk to be used
  data_disk_thin_provisioned  = ["true", "false"]
  vmdns             = ["192.168.0.2", "192.168.0.1"]
  vmgateway         = "192.168.0.1"
  tags = {
    "terraform-test-category"    = "terraform-test-tag"
    "terraform-test-category-02" = "terraform-test-tag-02"
  }
}
```

## Authors

Originally created by [Arman Keyoumarsi](https://github.com/Arman-Keyoumarsi)

## License

[MIT](LICENSE)
