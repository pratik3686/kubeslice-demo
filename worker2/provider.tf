provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    config_context = "arn:aws:eks:eu-central-1:734522607489:cluster/worker2-cluster"
    
  }
}
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "= 2.5.1"
    }
  }
}