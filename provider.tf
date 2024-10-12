terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.33.0"
    }
  }
}

provider "kubernetes" {
  # Configuration options
  config_path = "C:/Users/elsha/.kube/config"
}