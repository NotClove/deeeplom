terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  cloud {
    organization = "deeeplom"

    workspaces {
      name = "prod"
    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.YANDEX_CLOUD_ID
  zone      = local.default_zone
}
