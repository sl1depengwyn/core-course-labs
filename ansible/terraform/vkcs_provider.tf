terraform {
  required_providers {
    vkcs = {
      source  = "vk-cs/vkcs"
      version = "~> 0.1.12"
    }
  }
}

provider "vkcs" {
  username = var.vkc_username

  password = var.vkc_password

  project_id = var.vkc_project_id

  region = "RegionOne"

  auth_url = "https://infra.mail.ru:35357/v3/"
}
