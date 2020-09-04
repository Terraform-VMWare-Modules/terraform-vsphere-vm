// Simple Linux VM deployment
module "example-server-linuxvm" {
  source        = "Terraform-VMWare-Modules/vm/vsphere"
  version       = "Latest X.X.X"
  vmtemp        = "TemplateName"
  instances     = 1
  vmname        = "example-server-windows"
  vmrp          = "esxi/Resources"
  network_cards = ["Name of the Port Group in vSphere"]
  ipv4 = {
    "Name of the Port Group in vSphere" = ["10.0.0.1"] # To use DHCP create empty string for each instance
  }
  dc        = "Datacenter"
  datastore = "Data Store name(use ds_cluster for datastore cluster)"
}
// Example of Linux VM with more Advanced Features
module "example-server-linuxvm-advanced" {
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
  network_cards          = ["VM Network", "test-network"]
  ipv4submask            = ["24", "8"]
  ipv4 = {
    "VM Network" = ["192.168.0.4", ""] // Here the first instance will use Static Ip and Second set to DHCP
    "test"       = ["", "192.168.0.3"]
  }
  disk_label                = ["tpl-disk-1"]
  data_disk_label           = ["label1", "label2"]
  scsi_type                 = "lsilogic" # "pvscsi"
  scsi_controller           = 0
  data_disk_scsi_controller = [0, 1]
  disk_datastore            = "vsanDatastore"
  data_disk_datastore       = ["vsanDatastore", "nfsDatastore"]
  data_disk_size_gb         = [10, 5] // Aditional Disks to be used
  thin_provisioned          = [true, false]
  vmdns                     = ["192.168.0.2", "192.168.0.1"]
  vmgateway                 = "192.168.0.1"
  network_type              = ["vmxnet3", "vmxnet3"]
  tags = {
    "terraform-test-category"    = "terraform-test-tag"
    "terraform-test-category-02" = "terraform-test-tag-02"
  }
}

