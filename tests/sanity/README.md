# Sanity Test for new Functionality

**Copy of a TF Plan shoud be submmited with each PR, new functionality/variable should be explicitly added here under static values section in the main.tf file.**

### tfvars Example:

```hcl
viserver   = "fill"
viuser     = "fill"
vipassword = "fill"

vm = {
  linuxvm = {
    vmtemp           = "Template name",
    is_windows_image = false
    vmrp             = "fill"
    dc               = "fill",
    datastore        = "fill"
    vmfolder         = "fill"
    vmgateway        = "10.13.13.1"
    dns_servers      = ["1.1.1.1"]
    network = {
      "VM Port Group" = ["10.13.13.2", ""], # To use DHCP create Empty list for each instance
      "VM Port Group" = ["", ""]
    }
  },
  windowsvm = {
    vmtemp           = "fill"
    is_windows_image = true
    vmrp             = "fill" 
    dc               = "fill"
    vmfolder         = "fill"  
    datastore        = "fill"  
    dns_servers      = null
    vmgateway        = "10.13.13.1"
    network = {
      "VM Port Group" = ["10.13.13.2", ""], # To use DHCP create Empty list for each instance
      "VM Port Group" = ["", ""]
    }
  }
}
```

