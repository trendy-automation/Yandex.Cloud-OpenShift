variable "public_key_path" {
  description = "Path to public key file"
}

variable "yc_oauth_token" {
  description = "Yandex Cloud security OAuth token"
  default     = ""
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID where resources will be created"
  default     = ""
  type        = string
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID where resources will be created"
  default     = ""
  type        = string
}


//General Cluster Settings

variable "okd_project_name" {
  description = "Name of yc Cluster"
}
variable "okd_cluster_name" {
  description = "Name of yc Cluster"
}

variable "okd_image_family" {
  description = "family"
}


//yc VPC Variables


variable "okd_cidr_subnets" {
  description = "CIDR Blocks for private subnets in Availability Zones"
  type = list(string)
}


/**
  Bastion VM configuration variables
*/
variable "okd_bastion_cpu" {
    description = "Number CPU cores"
}
variable "okd_bastion_ram" {
    description = "Node RAM size"
}
variable "okd_bastion_ip" {
    description = "Bastion IP"
}
variable "okd_bastion_ram_disk" {
    description = "Bastion disk size"
}


/*
* The number should be divisable by the number of used
* yc Availability Zones without an remainder.
*/
variable "okd_kube_master_num" {
    description = "Number of Kubernetes Master Nodes"
}
variable "okd_kube_master_cpu" {
    description = "Number CPU cores"
}
variable "okd_kube_master_ram" {
    description = "Node RAM size"
}
variable "okd_kube_master_ips" {
    description = "Master IPs"
}
variable "okd_kube_master_disk" {
    description = "Master disk size"
}


variable "okd_kube_infra_num" {
    description = "Number of Kubernetes Infrastructure Nodes"
}
variable "okd_kube_infra_cpu" {
    description = "Number CPU cores"
}
variable "okd_kube_infra_ram" {
    description = "Node RAM size"
}
variable "okd_kube_infra_ips" {
    description = "Infra IPs"
}
variable "okd_kube_infra_disk" {
    description = "Infra disk size"
}

variable "okd_kube_worker_num" {
    description = "Number of Kubernetes Master Nodes"
}
variable "okd_kube_worker_cpu" {
    description = "Number CPU cores"
}
variable "okd_kube_worker_ram" {
    description = "Node RAM size"
}
variable "okd_kube_worker_ips" {
    description = "Worker IPs"
}
variable "okd_kube_worker_disk" {
    description = "Worker disk size"
}

variable "okd_availability_zones" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
}

variable "openshift_master_cluster_public_hostname" {
  description = "Public cluster master lb DNS-name"
}

/*
* yc ELB Settings
*
*/
variable "k8s_secure_api_port" {
    description = "Secure Port of K8S API Server"
}


variable "inventory_file" {
  description = "Where to store the generated inventory file"
}
