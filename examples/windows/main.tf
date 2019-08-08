// Example of basic Windows VM
module "example-server-windowsvm-withdatadisk" {
  source           = "Terraform-VMWare-Modules/vm/vsphere"
  version          = "1.0.0"
  vmtemp           = "TemplateName"
  is_windows_image = "true"
  instances        = 1
  vmname           = "example-server-windows"
  vmrp             = "esxi/Resources"
  network_cards    = ["Name of the POrt Group in vSphere"]
  ipv4 = {
    "Name of the POrt Group in vSphere" = ["10.0.0.1"] # To use DHCP create Empty list for each instance
  }
  dc        = "Datacenter"
  datastore = "Data Store name(use ds_cluster for datastore cluster)"
}
//Example of Windows VM customization with advanced features
module "example-server-windowsvm-advanced" {
  source                 = "Terraform-VMWare-Modules/vm/vsphere"
  version                = "1.0.0"
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
  network_cards          = ["VM Network", "test-netwrok"]
  ipv4submask            = ["24", "8"]
  ipv4 = {
    "VM Network" = ["192.168.0.4", ""] // Here the first instance will use Static Ip and Second DHCP
    "test"       = ["", "192.168.0.3"]
  }
  data_disk_size_gb = [10, 5] // Aditional Disk to be used
  thin_provisioned  = ["true", "false"]
  vmdns             = ["192.168.0.2", "192.168.0.1"]
  vmgateway         = "192.168.0.1"
  tags = {
    "terraform-test-category"    = "terraform-test-tag"
    "terraform-test-category-02" = "terraform-test-tag-02"
  }
  enable_disk_uuid = "true"
  auto_logon       = "true"
  run_once         = ["command01", "command02"]
  orgname          = "Terraform-Module"
  workgroup        = "Module-Test"
  is_windows_image = "true"
  firmware         = "efi"
  local_adminpass  = "Password123"
}