# Sanity Test for new Functionality

**Copy of a TF Plan shoud be submmited with each PR, new functionality/variable should be explicitly added here.**

### tfvars Example:

```hcl
viserver   = "fill"
viuser     = "fill"
vipassword = "fill"

vm = {
  linuxvm = {
    vmname           = "example-server-linux",
    vmtemp           = "Template name",
    instances        = 2
    is_windows_image = false
    vmrp             = "fill"
    dc               = "fill",
    datastore        = "fill"
    vmfolder         = "fill"
    vmgateway        = "10.13.13.1"
    dns_servers      = ["1.1.1.1"]
    data_disk = {
      disk1 = {
        size_gb                   = 3,
        thin_provisioned          = false,
        data_disk_scsi_controller = 0,
      },
      disk2 = {
        size_gb                   = 4,
        thin_provisioned          = true,
        data_disk_scsi_controller = 1,
      },
      disk3 = {
        size_gb                   = 5,
        thin_provisioned          = true,
        data_disk_scsi_controller = 1,
        datastore_id              = "datastore-90679"
      }
    }
    network = {
      "VM Port Group" = ["10.13.13.2", ""], # To use DHCP create Empty list for each instance
      "VM Port Group" = ["", ""]
    }
  },
  windowsvm = {
    vmname           = "example-server-windows",
    vmtemp           = "fill"
    instances        = 2
    is_windows_image = true
    vmrp             = "fill" 
    dc               = "fill"
    vmfolder         = "fill"  
    datastore        = "fill"  
    dns_servers      = null
    data_disk        = {}
    vmgateway        = "10.13.13.1"
    network = {
      "VM Port Group" = ["10.13.13.2", ""], # To use DHCP create Empty list for each instance
      "VM Port Group" = ["", ""]
    }
  }
}
```

