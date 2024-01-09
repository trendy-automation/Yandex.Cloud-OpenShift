resource "yandex_dns_zone" "zone1" {
  name        = "my-okd-zone"
  description = "desc"

  labels = {
    label1 = "label-1-okd"
  }

  zone             = "my-okd.jet.su."
  public           = true
  private_networks = [yandex_vpc_network.vpc.id]
}

resource "yandex_dns_recordset" "workers" {
	count = var.okd_kube_worker_num
	zone_id = yandex_dns_zone.zone1.id
	name    = "k8s-worker-${count.index}"
	type    = "A"
	ttl     = 300
	data = [element(var.okd_kube_worker_ips, count.index)]
}

resource "yandex_dns_recordset" "infras" {
	count = var.okd_kube_infra_num
	zone_id = yandex_dns_zone.zone1.id
	name    = "k8s-infra-${count.index}"
	type    = "A"
	ttl     = 300
	data = [element(var.okd_kube_infra_ips, count.index)]
}

resource "yandex_dns_recordset" "masters" {
	count = var.okd_kube_master_num
	zone_id = yandex_dns_zone.zone1.id
	name    = "k8s-master-${count.index}"
	type    = "A"
	ttl     = 300
	data = [element(var.okd_kube_master_ips, count.index)]
}

resource "yandex_dns_recordset" "okd-bastion" {
	zone_id = yandex_dns_zone.zone1.id
	name    = "okd-bastion"
	type    = "A"
	ttl     = 300
	data = [var.okd_bastion_ip]
}

resource "yandex_dns_recordset" "workers-ptr" {
	count = var.okd_kube_worker_num
	zone_id = yandex_dns_zone.zone1.id
	name    = element(var.okd_kube_worker_ips, count.index)
	type    = "PTR"
	ttl     = 300
	data = ["k8s-worker-${count.index}"]
}

resource "yandex_dns_recordset" "infras-ptr" {
	count = var.okd_kube_infra_num
	zone_id = yandex_dns_zone.zone1.id
	name    = element(var.okd_kube_infra_ips, count.index)
	type    = "PTR"
	ttl     = 300
	data = ["k8s-infra-${count.index}"]
}

resource "yandex_dns_recordset" "masters-ptr" {
	count = var.okd_kube_master_num
	zone_id = yandex_dns_zone.zone1.id
	name    = element(var.okd_kube_master_ips, count.index)
	type    = "PTR"
	ttl     = 300
	data = ["k8s-master-${count.index}"]
}

resource "yandex_dns_recordset" "okd-bastion-ptr" {
	zone_id = yandex_dns_zone.zone1.id
	name    = "${var.okd_bastion_ip}.in-addr.arpa."
	type    = "PTR"
	ttl     = 300
	data = ["okd-bastion"]
}