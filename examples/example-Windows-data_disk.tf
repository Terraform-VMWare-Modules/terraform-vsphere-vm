data "vsphere_storage_policy" "policy" {
  name = "policy1"
}

module "example-server-windowsvm-advanced" {
  source            = "Terraform-VMWare-Modules/vm/vsphere"
  version           = "X.X.X"
  dc                = "Datacenter"
  vmrp              = "cluster/Resources" #Works with ESXi/Resources
  vmfolder          = "Cattle"
  datastore_cluster = "Datastore Cluster" #You can use datastore variable instead
  vmtemp            = "TemplateName"
  instances         = 2
  vmname            = "AdvancedVM"
  domain          = "somedomain.com"
  network = {
    "Name of the Port Group in vSphere" = ["10.13.113.2", "10.13.113.3"] # To use DHCP create Empty list ["",""]
  }
  template_storage_policy_id = [data.vsphere_storage_policy.this.id] #Policy ID for the template disks
  data_disk = {
    disk1 = {
      size_gb                   = 30,
      thin_provisioned          = false,
      data_disk_scsi_controller = 0,
      storage_policy_id         = "ff45cc66-b624-4621-967f-1aef6437f568" #Different policy ID for data disks
    },
    disk2 = {
      size_gb                   = 70,
      thin_provisioned          = true,
      data_disk_scsi_controller = 1,
      datastore_id              = "datastore-90679"
    }
  }
  scsi_bus_sharing = "physicalSharing" // The modes are physicalSharing, virtualSharing, and noSharing
  scsi_type        = "lsilogic"        // Other acceptable value "pvscsi"
  scsi_controller  = 0                 // This will assign OS disk to controller 0
  dns_server_list  = ["192.168.0.2", "192.168.0.1"]
  vmgateway        = "192.168.0.1"
  enable_disk_uuid = true
  orgname          = "Terraform-Module"
  workgroup        = "Module-Test"
  is_windows_image = true
  firmware         = "efi"
  local_adminpass  = "Password@Strong"
}
