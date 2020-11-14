# Terraform vSphere examples

This directory contains various examples for deplpyong Linux/Windows VMs to a vSphere vCenter. 

## Getting started

__Create a connection.tf file and copy the following code.__

```hcl

# Configure the VMware vSphere Provider
provider "vsphere" {
  user           = "fill"
  password       = "fill"
  vsphere_server = "fill" 

  # if you have a self-signed cert
  allow_unverified_ssl = true
}
```

__Copy any of the exmpale tf files and fill the required data then run terraform init/plan/apply.__
