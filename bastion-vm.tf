resource "yandex_compute_instance" "bastion" {

    platform_id = "standard-v3"
    name        = "okd-bastion-vm"
    hostname    = "okd-bastion"
    description = "bastion host with ansible installation and internet access"
    zone = element(var.okd_availability_zones, 0) // Install into first subnet by default

    resources {
      cores  = var.okd_bastion_cpu
      memory = var.okd_bastion_ram
    }

    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.base_image.id
        type = "network-ssd"
        #snapshot_id = "${data.yandex_compute_snapshot.kubeadm.id}"
        # type_id = "network-nvme"
        size = var.okd_bastion_ram_disk
      }
    }

    network_interface {
      subnet_id = element(yandex_vpc_subnet.subnet, 0).id
      nat       = true
    }

    metadata = {
      ssh-keys  = "centos:${file("${var.public_key_path}")}"
    ##  user-data = "${file("./ignition/transpiled_config1.ign")}"
    ##  user-data = "${data.template_file.cloud-init.rendered}"
    }

}