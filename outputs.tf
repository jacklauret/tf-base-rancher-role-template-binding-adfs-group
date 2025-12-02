terraform {
  required_version = ">=1.10.6"
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = ">=8.3.1"
    }
  }

}

provider "rancher2" {
  api_url    = var.cluster_api_url
  access_key = var.rancher_access_key
  secret_key = var.rancher_secret_key
}