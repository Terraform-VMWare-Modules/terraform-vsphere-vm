// Simple Linux VM deployment
module "example-server-linuxvm" {
  source        = "Terraform-VMWare-Modules/vm/vsphere"
  version       = "Latest X.X.X"
  vmtemp        = "TemplateName"
  instances     = 1
  vmname        = "example-server-windows"
  vmrp          = "esxi/Resources"
  network = {
    "Network01" = ["10.13.113.2", "10.13.113.3"] # To use DHCP create Empty list ["",""]
    "Network02" = ["", ""]                       #Second Network will use the DHCP
  }
  dc        = "Datacenter"
  datastore = "Data Store name(use datastore_cluster for datastore cluster)"
}
// Example of Linux VM with more Advanced Features
module "example-server-linuxvm-advanced" {
  source                 = "Terraform-VMWare-Modules/vm/vsphere"
  vm_depends_on          = [module.example-server-linuxvm] # This force the second module to wait for first VM to be created first
  version                = "Latest X.X.X"
  dc                     = "Datacenter"
  vmrp                   = "cluster/Resources"
  vmfolder               = "Cattle"
  datastore_cluster      = "Datastore Cluster"
  vmtemp                 = "TemplateName"
  instances              = 2
  cpu_number             = 2
  ram_size               = 2096
  cpu_hot_add_enabled    = true
  cpu_hot_remove_enabled = true
  memory_hot_add_enabled = true
  vmname                 = "AdvancedVM"
  domain               = "somedomain.com"
  ipv4submask            = ["24", "8"]
  network = {
    "Network01" = ["10.13.113.2", "10.13.113.3"] # To use DHCP create Empty list ["",""]
    "Network02" = ["", ""]                       #Second Network will use the DHCP
  }
  dns_server_list           = ["192.168.0.2", "192.168.0.1"]
  vmgateway                 = "192.168.0.1"
  network_type              = ["vmxnet3", "vmxnet3"]
  tags = {
    "terraform-test-category"    = "terraform-test-tag"
    "terraform-test-category-02" = "terraform-test-tag-02"
  }
}

