module "example-server-linux" {
  source            = "Module Source"                 
  version           = "v0.3.0"
  vmtemp            = "TemplateName"           
  instances         = 1                        
  vmname            = "example-server-windows" 
  vmrp              = "esxi/Resources"  
  vlan              = "Name of the VLAN in vSphere"
  data_disk         = "true"
  data_disk_size_gb = 20
  dc                = "Datacenter"
  ds_cluster        = "Data Store Cluster name"
}
