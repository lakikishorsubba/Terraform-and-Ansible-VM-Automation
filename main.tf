terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

# Create Vagrantfile for each VM
resource "local_file" "vagrantfile" {
  for_each = var.vms

  filename = "${path.module}/Vagrantfile-${each.key}"
  content = templatefile("${path.module}/Vagrantfile.tpl", {
    vm_name  = each.key
    hostname = each.value.hostname
    ip       = each.value.ip
    memory   = each.value.memory
    cpus     = each.value.cpus
    box      = var.box_image
  })
}

# Provision VMs using Vagrant
resource "null_resource" "provision_vm" {
  for_each = var.vms

  depends_on = [local_file.vagrantfile]

  triggers = {
    vagrantfile_content = local_file.vagrantfile[each.key].content
  }

  provisioner "local-exec" {
    command     = "vagrant up"
    working_dir = path.module
    environment = {
      VAGRANT_VAGRANTFILE = "Vagrantfile-${each.key}"
    }
  }
}

# Generate Ansible inventory
resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventory.ini"
  content = templatefile("${path.module}/inventory.tpl", {
    vms = var.vms
  })

  depends_on = [null_resource.provision_vm]
}
