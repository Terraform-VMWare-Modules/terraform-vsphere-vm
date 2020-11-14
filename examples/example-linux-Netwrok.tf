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
  ipv4submask            = ["24", "8"]
  network = {
    "Network01" = ["10.13.113.2", "10.13.113.3"] # To use DHCP create Empty list ["",""]
    "Network02" = ["", ""]                       #Second Network will use the DHCP
  }
  disk_label      = ["tpl-disk-1"]
  data_disk_label = ["label1", "label2"]
  scsi_type       = "lsilogic" # "pvscsi"
  disk_datastore  = "vsanDatastore"
  vmdns           = ["192.168.0.2", "192.168.0.1"]
  vmgateway       = "192.168.0.1"
  network_type    = ["vmxnet3", "vmxnet3"]
  tags = {
    "terraform-test-category-01" = "terraform-test-tag-01"
    "terraform-test-category-02" = "terraform-test-tag-02"
  }
}

