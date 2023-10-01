variable "YANDEX_CLOUD_ID" {
  type        = string
}

variable "folder_id" {
  type        = string
}

variable "yc_token" {
  type        = string
}

variable "SSH_KEYS" {
  type = map
  default = {
    "ubuntu" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQXUe7vQNS480AEp0kDFa4boKGuLT+ksWVQTXCWqGsz/RW+lXVVnWngB+L87sA5Jdj4PaXtUyxLXzDjiJ76i2OJWm5HDl//nAb1v2qg6ocscXPa6n5lxdDvHivXmUEPAyd8LAjLikgWi20XzKrkogNYfs0fLdS5LTvC7mLm9Lz0X1IEVXrBFHM1f6yRLreXbjh1ZkewgfKX/LJebfyA7XU2DpTl0zncpA/wEbnb0VS0f0Sl4bMCu51WDNsrodH6hTIIm3izM7/Sid4iXpsHtHErLioZaQbUsgGCwBESf0W/6x4n1qQUj2QMxcMQGm9WK6or2Nug0UXGAh33tyCYk1oYez9Cb6ICF77AVSFuxOqBE8dh8DJmIkyYzst6C4qNQ4DcX9wSwSSIV/rO7T/WhqbZYZE/e3TSHCcQjQzY5xoQrJGBnCqgP3Ns8wesfSh675nQhBiL3UWgFh+QcG1NVfJDUxL2HXPyT1ryJYLa9Xa9CDk19LeU/uWTTE+JVMcpjU= clove@Clovebook.local"
  }
}

variable "K8S_VERSION" {
  default = "1.27"
}

variable "CLUSTER_IPV4_RANGE" {
  default = "10.112.0.0/16"
}

variable "SERVICE_IPV4_RANGE" {
  default = "10.96.0.0/16"
}
