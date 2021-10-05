# Smoke Test

You need to run the plan using private.tfvars 

### Example:

```hcl
viserver   = "fill"
viuser     = "fill"
vipassword = "fill"

vm = {
  linuxvm = {
    vmname            = "example-server-linux",
    vmtemp            = "fill"
    content_library   = null
    annotation        = "Terraform Smoke Test"
    instances         = 0
    is_windows_image  = false
    vmrp              = "fill"
    dc                = "fill" 
    datastore_cluster = "fill"
    vmfolder          = "fill"
    vmgateway         = "10.13.13.1"
    dns_servers       = ["1.1.1.1"]
    network = {
      "VM Networks" = ["10.13.13.2"],
    }
    disk_size_gb = [ 20 ]
  }
}
```
