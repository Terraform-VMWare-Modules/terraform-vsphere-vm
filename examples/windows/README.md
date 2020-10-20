# Terraform vSphere WindowsVM example

For Virtual Machine Provisioning with Windows customization.

> Note: For module to work it needs number of required variables corresponding to an existing resources in vSphere. Please refer to variable section for the list of required variables.

## Usage

Following example contains the bare minimum options to be configured for the Windows VM deployment.

### Example of basic Windows VM

```hcl
module "example-server-windowsvm-withdatadisk" {
  source        = "Terraform-VMWare-Modules/vm/vsphere"
  version       = "Latest X.X.X"
  vmtemp        = "TemplateName"
  instances     = 1
  vmname        = "example-server-windows"
  vmrp          = "esxi/Resources"
  network_cards = ["Name of the Port Group in vSphere"]
  ipv4 = {
    "Name of the Port Group in vSphere" = ["10.0.0.1"] # To use DHCP create Empty list for each instance
  }
  dc        = "Datacenter"
  datastore = "Data Store name(use ds_cluster for datastore cluster)"
}
```

### Example of Windows VM customization with advanced features

```hcl
module "example-server-windowsvm-advanced" {
  source                 = "Terraform-VMWare-Modules/vm/vsphere"
  version                = "Latest X.X.X"
  dc                     = "Datacenter"
  vmrp                   = "cluster/Resources"
  vmfolder               = "Cattle"
  ds_cluster             = "Datastore Cluster"
  vmtemp                 = "TemplateName"
  instances              = 2
  cpu_number             = 2
  ram_size               = 2096
  cpu_hot_add_enabled    = true
  cpu_hot_remove_enabled = true
  memory_hot_add_enabled = true
  vmname                 = "AdvancedVM"
  vmdomain               = "somedomain.com"
  network_cards          = ["VM Network", "test-netwrok"]
  ipv4submask            = ["24", "8"]
  ipv4 = {
    "VM Network" = ["192.168.0.4", ""] // Here the first instance will use Static Ip and Second DHCP
    "test"       = ["", "192.168.0.3"]
  }
  data_disk_size_gb = [10, 5] // Aditional Disks to be used
  disk_label                 = ["tpl-disk-1"]
  data_disk_label            = ["label1", "label2"]
  scsi_type = "lsilogic" # "pvscsi"
  scsi_controller = 0 # template disk scsi_controller
  data_disk_scsi_controller  = [0, 1]
  disk_datastore             = "vsanDatastore"
  data_disk_datastore        = ["vsanDatastore", "nfsDatastore"]
  thin_provisioned  = [true, false]
  vmdns             = ["192.168.0.2", "192.168.0.1"]
  vmgateway         = "192.168.0.1"
  network_type = ["vmxnet3", "vmxnet3"]
  tags = {
    "terraform-test-category"    = "terraform-test-tag"
    "terraform-test-category-02" = "terraform-test-tag-02"
  }
  enable_disk_uuid = true
  auto_logon       = true
  run_once         = ["mkdir c:\\admin", "echo runonce-test >> c:\\admin\\logs.txt", "powershell.exe \"New-Item C:\\test.txt\""]
  orgname          = "Terraform-Module"
  workgroup        = "Module-Test"
  is_windows_image = true
  firmware         = "efi"
  local_adminpass  = "Password@Strong"
}
```

### Example of template disk size configuration

Below example will deploy an instance of a virtual machine from a Windows template. The virtual machine makes use of a template that is 16GB in size originally but is expanded to 32GB.
To override the disks configured in the virtual machine template add the `disk_size_gb` variable (list), and configure the disk sizes as integers to match the templates amount of disks.

```hcl
module "example-server-windowsvm-override-template-size" {
  source                 = "Terraform-VMWare-Modules/vm/vsphere"
  version                = "Latest X.X.X"
  dc                     = "Datacenter"
  vmrp                   = "cluster/Resources"
  vmfolder               = "Cattle"
  ds_cluster             = "Datastore Cluster"
  vmtemp                 = "TemplateName"
  instances              = 2
  cpu_number             = 2
  ram_size               = 2096
  vmname                 = "AdvancedVM"
  vmdomain               = "somedomain.com"
  network_cards          = ["VM Network"]
  ipv4submask            = ["24"]
  ipv4 = {
    "VM Network" = ["192.168.0.4"]
  }
  disk_size_gb = [32] // Value to override the template disk size (add x amount of values to match the amount of disks in the template)
  disk_label                 = ["tpl-disk-1"]
  data_disk_size_gb = [10] // Aditional Disk to be used
  data_disk_label            = ["label1"]
  disk_datastore             = "vsanDatastore"
  data_disk_datastore        = ["vsanDatastore"]
  thin_provisioned  = [true]
  vmdns             = ["192.168.0.2"]
  vmgateway         = "192.168.0.1"
  network_type = ["vmxnet3"]
  tags = {
    "terraform-test-category"    = "terraform-test-tag"
  }
  enable_disk_uuid = true
  auto_logon       = true
  run_once         = ["mkdir c:\\admin", "echo runonce-test >> c:\\admin\\logs.txt", "powershell.exe \"New-Item C:\\test.txt\""]
  orgname          = "Terraform-Module"
  workgroup        = "Module-Test"
  is_windows_image = true
  firmware         = "efi"
  local_adminpass  = "Password@Strong"
}
```

## Authors

Originally created by [Arman Keyoumarsi](https://github.com/Arman-Keyoumarsi)

## License

[MIT](LICENSE)
