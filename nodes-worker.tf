
 resource  "yandex_compute_disk" "worker_docker_storage_disk" {
         count       = var.okd_kube_master_num
         name = "k8s-worker-${count.index}-docker-storage-disk"
         size = var.okd_kube_worker_disk
         type = "network-ssd"
         zone = element(var.okd_availability_zones, 0)
}


resource "yandex_compute_instance" "worker" {

    count = var.okd_kube_worker_num
    platform_id = "standard-v3"
    name        = "k8s-worker-${count.index}"
    hostname    = "k8s-worker-${count.index}"
    description = "k8s-worker-${count.index} of the ${var.okd_project_name} ${var.okd_cluster_name} cluster"
    zone = element(var.okd_availability_zones, 0)


    resources {
      cores  = var.okd_kube_worker_cpu
      memory = var.okd_kube_worker_ram
    }

    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.base_image.id
        type = "network-ssd"
        #snapshot_id = "${data.yandex_compute_snapshot.kubeadm.id}"
        #type_id = "network-nvme"
        size = "32"
      }
    }
    
     
  # Storage for Docker, see:
  # https://docs.openshift.org/latest/install_config/install/host_preparation.html#configuring-docker-storage
    secondary_disk {
            auto_delete = true
            device_name = "sdf"
            disk_id = element(yandex_compute_disk.worker_docker_storage_disk, count.index).id
    }

    network_interface {
      subnet_id = element(yandex_vpc_subnet.subnet, count.index).id
      nat       = false
    }

    metadata = {
      ssh-keys  = "centos:${file("${var.public_key_path}")}"
    ##  user-data = "${data.template_file.cloud-init.rendered}"
    }

}