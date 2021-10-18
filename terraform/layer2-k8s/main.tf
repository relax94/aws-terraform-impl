terraform {
  required_version = "0.15.1"

  required_providers {
    aws = {
      source  = "aws"
      version = "3.53.0"
    }
    kubernetes = {
      source  = "kubernetes"
      version = "2.4.1"
    }
    helm = {
      source  = "helm"
      version = "2.2.0"
    }
  }
}

data "terraform_remote_state" "layer1-aws" {
  backend = "s3"
  config = {
    bucket  = var.remote_state_bucket
    key     = "${var.remote_state_key}/terraform.tfstate"
    region  = var.region
    encrypt = "true"
  }
  workspace = terraform.workspace
}

data "aws_caller_identity" "current" {}
