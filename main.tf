data "vsphere_datacenter" "dc" {
  name = "${var.dc}"
}
data "vsphere_datastore_cluster" "datastore_cluster" {
  name          = "${var.ds_cluster}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_resource_pool" "pool" {
  name          = "${var.vmrp}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_network" "network" {
  name          = "${var.vlan}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_virtual_machine" "template" {
  name          = "${var.vmtemp}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
// Creating Linux VM with no Data Disk. Note: This is the default option!!
resource "vsphere_virtual_machine" "LinuxVM" {
  count            = "${ var.is_windows_image != "true" && var.data_disk == "false" ? var.instances : 0}"
  //Name of the server with index of count +1 to start from 1
  name             = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  folder           = "${var.vmfolder}"

  datastore_cluster_id = "${data.vsphere_datastore_cluster.datastore_cluster.id}"

  num_cpus  = "${var.cpu_number}"
  memory    = "${var.ram_size}"
  guest_id  = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"
  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }
  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
        domain    = "${var.vmdomain}"
      }

      network_interface {
        ipv4_address = "${element(var.ipaddress, count.index)}"
        ipv4_netmask = "${var.ipv4submask}"      
        }
      dns_server_list = "${var.vmdns}"
      ipv4_gateway    = "${var.vmgateway}"
    }
  }
}
// Creating Linux VM with Data Disk.
resource "vsphere_virtual_machine" "LinuxVM-withDataDisk" {
  count            = "${ var.is_windows_image != "true" && var.data_disk == "true" ? var.instances : 0}"
  //Name of the server with index of count +1 to start from 1
  name             = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  folder           = "${var.vmfolder}"

  datastore_cluster_id = "${data.vsphere_datastore_cluster.datastore_cluster.id}"

  num_cpus  = "${var.cpu_number}"
  memory    = "${var.ram_size}"
  guest_id  = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"
  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }
  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }
  disk {
    label            = "disk1"
    size             = "${var.data_disk_size_gb}"
    unit_number = 1
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
        domain    = "${var.vmdomain}"
      }

      network_interface {
        ipv4_address = "${element(var.ipaddress, count.index)}"
        ipv4_netmask = "${var.ipv4submask}"      
        }
      dns_server_list = "${var.vmdns}"
      ipv4_gateway    = "${var.vmgateway}"
    }
  }
}
// Creating Windows VM with no Data Disk.
resource "vsphere_virtual_machine" "WindowsVM" {
  count            = "${ var.is_windows_image == "true" && var.data_disk == "false" && var.join_windomain == "false" ? var.instances : 0}"

  //Name of the server with index of count +1 to start from 1
  name             = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  folder           = "${var.vmfolder}"

  datastore_cluster_id = "${data.vsphere_datastore_cluster.datastore_cluster.id}"

  num_cpus  = "${var.cpu_number}"
  memory    = "${var.ram_size}"
  guest_id  = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"
  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }
  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      windows_options {
        computer_name = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
        admin_password = "${var.winadminpass}"
        run_once_command_list = "${var.run_once}"
      }

      network_interface {
        ipv4_address = "${element(var.ipaddress, count.index)}"
        ipv4_netmask = "${var.ipv4submask}"
      }
      dns_server_list = "${var.vmdns}"
      ipv4_gateway    = "${var.vmgateway}"
    }
  }
}
// Creating Windows VM with Data Disk.
resource "vsphere_virtual_machine" "WindowsVM-withDataDisk" {
  count            = "${ var.is_windows_image == "true" && var.data_disk == "true" && var.join_windomain == "false" ? var.instances : 0}"

  //Name of the server with index of count +1 to start from 1
  name             = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  folder           = "${var.vmfolder}"

  datastore_cluster_id = "${data.vsphere_datastore_cluster.datastore_cluster.id}"

  num_cpus  = "${var.cpu_number}"
  memory    = "${var.ram_size}"
  guest_id  = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"
  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }
  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }
  disk {
    label            = "disk1"
    size             = "${var.data_disk_size_gb}"
    unit_number = 1
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      windows_options {
        computer_name = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
        admin_password = "${var.winadminpass}"
        run_once_command_list = "${var.run_once}"
      }

      network_interface {
        ipv4_address = "${element(var.ipaddress, count.index)}"
        ipv4_netmask = "${var.ipv4submask}"
      }
      dns_server_list = "${var.vmdns}"
      ipv4_gateway    = "${var.vmgateway}"
    }
  }
}
// Creating Windows VM with no Data Disk. (Join to Domain)
resource "vsphere_virtual_machine" "WindowsVM-Domain" {
  count            = "${ var.is_windows_image == "true" && var.data_disk == "false" && var.join_windomain == "true" ? var.instances : 0}"

  //Name of the server with index of count +1 to start from 1
  name             = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  folder           = "${var.vmfolder}"

  datastore_cluster_id = "${data.vsphere_datastore_cluster.datastore_cluster.id}"

  num_cpus  = "${var.cpu_number}"
  memory    = "${var.ram_size}"
  guest_id  = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"
  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }
  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      windows_options {
        computer_name = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
        admin_password = "${var.winadminpass}"
        join_domain    = "${var.vmdomain}"
        domain_admin_user = "${var.domainuser}"
        domain_admin_password = "${var.domainpass}"
        organization_name = "${var.orgname}"
        run_once_command_list = "${var.run_once}"
        product_key = "${var.productkey}"
      }

      network_interface {
        ipv4_address = "${element(var.ipaddress, count.index)}"
        ipv4_netmask = "${var.ipv4submask}"
      }
      dns_server_list = "${var.vmdns}"
      ipv4_gateway    = "${var.vmgateway}"
    }
  }
}

// Creating Windows VM with Data Disk. (Join to Domain)
resource "vsphere_virtual_machine" "WindowsVM-withDataDisk-Domain" {
  count            = "${ var.is_windows_image == "true" && var.data_disk == "true" && var.join_windomain == "true" ? var.instances : 0}"

  //Name of the server with index of count +1 to start from 1
  name             = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  folder           = "${var.vmfolder}"

  datastore_cluster_id = "${data.vsphere_datastore_cluster.datastore_cluster.id}"

  num_cpus  = "${var.cpu_number}"
  memory    = "${var.ram_size}"
  guest_id  = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"
  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }
  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }
  disk {
    label            = "disk1"
    size             = "${var.data_disk_size_gb}"
    unit_number = 1
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      windows_options {
        computer_name = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
        admin_password = "${var.winadminpass}"
        join_domain    = "${var.vmdomain}"
        domain_admin_user = "${var.domainuser}"
        domain_admin_password = "${var.domainpass}"
        organization_name = "${var.orgname}"
        run_once_command_list = "${var.run_once}"
        product_key = "${var.productkey}"
      }

      network_interface {
        ipv4_address = "${element(var.ipaddress, count.index)}"
        ipv4_netmask = "${var.ipv4submask}"
      }
      dns_server_list = "${var.vmdns}"
      ipv4_gateway    = "${var.vmgateway}"
    }
  }
}