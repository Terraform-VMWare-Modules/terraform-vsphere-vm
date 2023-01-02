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
  network      = [
      {
        ip_address     = "10.13.113.2"
        network_type   = "vmxnet3"
        port_group     = "Network01"
        netmask        = ""
      },
      {
        ip_address     = "10.13.113.3"
        network_type   = "vmxnet3"
        port_group     = "Network01"
        netmask        = ""
      },
      {
        ip_address     = ""
        network_type   = "vmxnet3"
        port_group     = "Network02"
        netmask        = ""
      },
      {
        ip_address     = ""
        network_type   = "vmxnet3"
        port_group     = "Network02"
        netmask        = ""
      },
  ]

  disk_datastore  = "vsanDatastore"
  dns_server_list = ["192.168.0.2", "192.168.0.1"]
  vmgateway       = "192.168.0.1"
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
  network      = [
      {
        ip_address     = "10.13.113.2/28"
        network_type   = "vmxnet3"
        port_group     = "Network01"
      },
      {
        ip_address     = "10.13.113.3/28"
        network_type   = "vmxnet3"
        port_group     = "Network01"
      },
      {
        ip_address     = ""
        network_type   = "vmxnet3"
        port_group     = "Network02"
      },
      {
        ip_address     = ""
        network_type   = "vmxnet3"
        port_group     = "Network02"
      },
      {
        ip_address     = "10.13.0.2/26"
        network_type   = "vmxnet3"
        port_group     = "Network03"
      },
      {
        ip_address     = "10.13.0.3/26"
        network_type   = "vmxnet3"
        port_group     = "Network03"
      },

  ]
  disk_datastore  = "vsanDatastore"
  dns_server_list = ["192.168.0.2", "192.168.0.1"]
  vmgateway       = "192.168.0.1"
}

