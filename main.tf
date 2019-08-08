data "vsphere_datacenter" "dc" {
  name = var.dc
}

data "vsphere_datastore_cluster" "datastore_cluster" {
  count         = var.ds_cluster != "" ? 1 : 0
  name          = var.ds_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  count         = var.datastore != "" && var.ds_cluster == "" ? 1 : 0
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.vmrp
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  count         = var.network_cards != null ? length(var.network_cards) : 0
  name          = var.network_cards[count.index]
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vmtemp
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_tag_category" "category" {
  count = var.tags != null ? length(var.tags) : 0
  name  = keys(var.tags)[count.index]
}

data "vsphere_tag" "tag" {
  count       = var.tags != null ? length(var.tags) : 0
  name        = var.tags[keys(var.tags)[count.index]]
  category_id = "${data.vsphere_tag_category.category[count.index].id}"
}

locals {
  len = length(var.ipv4submask) #Used for Subnet handeling
}

// Cloning a Linux VM from a given template. Note: This is the default option!!
resource "vsphere_virtual_machine" "Linux" {
  count = var.is_windows_image != "true" ? var.instances : 0

  name = "%{if var.vmnameliteral != ""}${var.vmnameliteral}%{else}${var.vmname}${count.index + 1}${var.vmnamesuffix}%{endif}"

  resource_pool_id  = data.vsphere_resource_pool.pool.id
  folder            = var.vmfolder
  tags              = data.vsphere_tag.tag[*].id
  custom_attributes = var.custom_attributes
  annotation        = var.annotation
  extra_config      = var.extra_config
  firmware          = var.firmware
  enable_disk_uuid  = var.enable_disk_uuid

  datastore_cluster_id = var.ds_cluster != "" ? data.vsphere_datastore_cluster.datastore_cluster[0].id : null
  datastore_id         = var.datastore != "" ? data.vsphere_datastore.datastore[0].id : null

  num_cpus               = var.cpu_number
  num_cores_per_socket   = var.num_cores_per_socket
  cpu_hot_add_enabled    = var.cpu_hot_add_enabled
  cpu_hot_remove_enabled = var.cpu_hot_remove_enabled
  memory                 = var.ram_size
  memory_hot_add_enabled = var.memory_hot_add_enabled
  guest_id               = data.vsphere_virtual_machine.template.guest_id
  scsi_type              = data.vsphere_virtual_machine.template.scsi_type


  dynamic "network_interface" {
    for_each = var.network_cards
    content {
      network_id   = data.vsphere_network.network[network_interface.key].id
      adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
    }
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks[0].eagerly_scrub
  }

  dynamic "disk" {
    for_each = var.data_disk_size_gb
    content {
      label            = "disk${disk.key + 1}"
      size             = var.data_disk_size_gb[disk.key]
      unit_number      = disk.key + 1
      thin_provisioned = var.thin_provisioned != null ? var.thin_provisioned[disk.key] : null
      eagerly_scrub    = var.eagerly_scrub != null ? var.eagerly_scrub[disk.key] : null
    }
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    linked_clone  = var.linked_clone
    timeout       = var.timeout

    customize {
      linux_options {
        host_name    = "%{if var.vmnameliteral != ""}${var.vmnameliteral}%{else}${var.vmname}${count.index + 1}${var.vmnamesuffix}%{endif}"
        domain       = var.vmdomain
        hw_clock_utc = var.hw_clock_utc
      }

      dynamic "network_interface" {
        for_each = var.network_cards
        content {
          ipv4_address = var.ipv4[var.network_cards[network_interface.key]][count.index]
          ipv4_netmask = "%{if local.len == 1}${var.ipv4submask[0]}%{else}${var.ipv4submask[network_interface.key]}%{endif}"
        }
      }
      dns_server_list = var.vmdns
      dns_suffix_list = var.dns_suffix_list
      ipv4_gateway    = var.vmgateway
    }
  }
}

resource "vsphere_virtual_machine" "Windows" {
  count = var.is_windows_image == "true" ? var.instances : 0

  name = "%{if var.vmnameliteral != ""}${var.vmnameliteral}%{else}${var.vmname}${count.index + 1}${var.vmnamesuffix}%{endif}"

  resource_pool_id  = data.vsphere_resource_pool.pool.id
  folder            = var.vmfolder
  tags              = data.vsphere_tag.tag[*].id
  custom_attributes = var.custom_attributes
  annotation        = var.annotation
  extra_config      = var.extra_config
  firmware          = var.firmware
  enable_disk_uuid  = var.enable_disk_uuid

  datastore_cluster_id = var.ds_cluster != "" ? data.vsphere_datastore_cluster.datastore_cluster[0].id : null
  datastore_id         = var.datastore != "" ? data.vsphere_datastore.datastore[0].id : null

  num_cpus               = var.cpu_number
  num_cores_per_socket   = var.num_cores_per_socket
  cpu_hot_add_enabled    = var.cpu_hot_add_enabled
  cpu_hot_remove_enabled = var.cpu_hot_remove_enabled
  memory                 = var.ram_size
  memory_hot_add_enabled = var.memory_hot_add_enabled
  guest_id               = data.vsphere_virtual_machine.template.guest_id
  scsi_type              = data.vsphere_virtual_machine.template.scsi_type


  dynamic "network_interface" {
    for_each = var.network_cards
    content {
      network_id   = data.vsphere_network.network[network_interface.key].id
      adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
    }
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks[0].eagerly_scrub
  }

  dynamic "disk" {
    for_each = var.data_disk_size_gb
    content {
      label            = "disk${disk.key + 1}"
      size             = var.data_disk_size_gb[disk.key]
      unit_number      = disk.key + 1
      thin_provisioned = var.thin_provisioned != null ? var.thin_provisioned[disk.key] : null
      eagerly_scrub    = var.eagerly_scrub != null ? var.eagerly_scrub[disk.key] : null
    }
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    linked_clone  = var.linked_clone
    timeout       = var.timeout

    customize {
      windows_options {
        computer_name         = "%{if var.vmnameliteral != ""}${var.vmnameliteral}%{else}${var.vmname}${count.index + 1}${var.vmnamesuffix}%{endif}"
        admin_password        = var.local_adminpass
        workgroup             = var.workgroup
        join_domain           = var.windomain
        domain_admin_user     = var.domain_admin_user
        domain_admin_password = var.domain_admin_password
        organization_name     = var.orgname
        run_once_command_list = var.run_once
        auto_logon            = var.auto_logon
        auto_logon_count      = var.auto_logon_count
        time_zone             = var.time_zone
        product_key           = var.productkey
        full_name             = var.full_name
      }

      dynamic "network_interface" {
        for_each = var.network_cards
        content {
          ipv4_address = var.ipv4[var.network_cards[network_interface.key]][count.index]
          ipv4_netmask = "%{if local.len == 1}${var.ipv4submask[0]}%{else}${var.ipv4submask[network_interface.key]}%{endif}"
        }
      }
      dns_server_list = var.vmdns
      dns_suffix_list = var.dns_suffix_list
      ipv4_gateway    = var.vmgateway
    }
  }
}