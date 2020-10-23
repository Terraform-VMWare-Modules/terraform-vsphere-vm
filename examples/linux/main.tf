// Simple Linux VM deployment
module "example-server-linuxvm" {
  source        = "Terraform-VMWare-Modules/vm/vsphere"
  version       = "Latest X.X.X"
  vmtemp        = "TemplateName"
  vmname        = "example-server-windows"
  vmrp          = "esxi/Resources"
  network_cards = {
    "Name of the Port Group in vSphere" = {
      ipv4 = "10.0.0.1" # To use DHCP create empty string
    }
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
  cpu_number             = 2
  ram_size               = 2096
  cpu_hot_add_enabled    = true
  cpu_hot_remove_enabled = true
  memory_hot_add_enabled = true
  vmname                 = "AdvancedVM"
  vmdomain               = "somedomain.com"
  network_cards          = {
    "VM Network" = {
      ipv4 = "192.168.0.4"
      ipv4submask = "24"
      type = "vmxnet3"
    }
  }
  data_disk = {
    label1 = {
      size_gb = 10,
      thin_provisioned = false
      data_disk_scsi_controller = 0
      data_disk_datastore = "vsanDatastore"
    },
    disk2 = {
      label2 = 5,
      thin_provisioned = true
      data_disk_scsi_controller = 1
      data_disk_datastore = "nfsDatastore"
    }
  }
  scsi_type                 = "lsilogic" # "pvscsi"
  scsi_controller           = 0
  disk_datastore            = "vsanDatastore"
  vmdns                     = ["192.168.0.2", "192.168.0.1"]
  vmgateway                 = "192.168.0.1"
  tags = {
    "terraform-test-category"    = "terraform-test-tag"
    "terraform-test-category-02" = "terraform-test-tag-02"
  }
}

