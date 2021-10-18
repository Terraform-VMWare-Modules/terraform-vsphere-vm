// Single VM deployment with literal name
module "example-server-single" {
  source       = "Terraform-VMWare-Modules/vm/vsphere"
  version      = "Latest X.X.X"
  vmtemp       = "TemplateName"
  staticvmname = "liternalvmname"
  vmrp         = "esxi/Resources"
  network = {
    "Name of the Port Group in vSphere" = ["10.13.113.2"]
  }
  dc        = "Datacenter"
  datastore = "Data Store name(use datastore_cluster for datastore cluster)"
}

# Vmname Output -> liternalvmname
//Sclae out Static VMs
variable "name" {
  default = ["staticvmname", "staticvmname01"]
}

module "example-server-single" {
  source       = "Terraform-VMWare-Modules/vm/vsphere"
  for_each     = toset(var.name)
  version      = "Latest X.X.X"
  vmtemp       = "TemplateName"
  staticvmname = "liternalvmname"
  vmrp         = "esxi/Resources"
  network = {
    "Name of the Port Group in vSphere" = ["10.13.113.2"]
  }
  dc        = "Datacenter"
  datastore = "Data Store name(use datastore_cluster for datastore cluster)"
}
// Example of multiple VM deployment with complex naming standard
# Define Environment Variable to switch between Environments
variable "env" {
  default = "dev"
}
module "example-server-multi" {
  source       = "Terraform-VMWare-Modules/vm/vsphere"
  version      = "Latest X.X.X"
  vmtemp       = "TemplateName"
  instances    = 2
  vmname       = "advancevm"
  vmnameformat = "%03d${var.env}"
  vmrp         = "esxi/Resources"
  network = {
    "Name of the Port Group in vSphere" = ["10.13.113.2", ""]
  }
  dc        = "Datacenter"
  datastore = "Data Store name(use datastore_cluster for datastore cluster)"
}
# Vmname Output -> advancevm001dev, advancevm002dev
#
//Example of appending domain name to vm name

variable "domain" {
  default = "somedomain.com"
}
module "example-server-multi" {
  source       = "Terraform-VMWare-Modules/vm/vsphere"
  version      = "Latest X.X.X"
  vmtemp       = "TemplateName"
  instances    = 2
  vmname       = "advancevm"
  vmnameformat = "%03d.${var.domain}"
  vmrp         = "esxi/Resources"
  network = {
    "Name of the Port Group in vSphere" = ["10.13.113.2", ""]
  }
  dc        = "Datacenter"
  datastore = "Data Store name(use datastore_cluster for datastore cluster)"
}
# Vmname Output -> advancevm001.somedomain.com, advancevm002dev.somedomain.com
