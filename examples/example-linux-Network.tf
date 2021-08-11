// Example of Linux VM with more Advanced Features
module "example-server-linuxvm-advanced" {
  source            = "Terraform-VMWare-Modules/vm/vsphere"
  version           = "Latest X.X.X"
  dc                = "Datacenter"
  vmrp              = "cluster/Resources"
  vmfolder          = "Cattle"
  datastore_cluster = "Datastore Cluster"
  vmtemp            = "TemplateName"
  instances         = 2
  vmname            = "AdvancedVM"
  domain            = "somedomain.com"
  ipv4submask       = ["24", "8"]
  network = {
    "Network01" = ["10.13.113.2", "10.13.113.3"] # To use DHCP create Empty list ["",""]
    "Network02" = ["", ""]                       #Second Network will use the DHCP
  }
  disk_datastore  = "vsanDatastore"
  dns_server_list = ["192.168.0.2", "192.168.0.1"]
  vmgateway       = "192.168.0.1"
  network_type    = ["vmxnet3", "vmxnet3"]
}

// Example of Linux VM with Network CIDR
module "example-server-linuxvm-advanced" {
  source            = "Terraform-VMWare-Modules/vm/vsphere"
  version           = "Latest X.X.X"
  dc                = "Datacenter"
  vmrp              = "cluster/Resources"
  vmfolder          = "Cattle"
  datastore_cluster = "Datastore Cluster"
  vmtemp            = "TemplateName"
  instances         = 2
  vmname            = "AdvancedVM"
  domain            = "somedomain.com"
  network = {
    "Network01" = ["10.13.113.2/28", "10.13.113.3/28"] # To use DHCP create Empty list ["",""]
    "Network02" = ["", ""]                             #Second Network will use the DHCP
    "Network03" = ["10.13.0.2/26", "10.13.0.3/26"]
  }
  disk_datastore  = "vsanDatastore"
  dns_server_list = ["192.168.0.2", "192.168.0.1"]
  vmgateway       = "192.168.0.1"
  network_type    = ["vmxnet3", "vmxnet3"]
}

