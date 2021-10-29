terraform {
  required_providers {
    lacework = {
      source = "lacework/lacework"
      version = "~> 0.3"
    }
  }
}

provider "aws" {
  region = var.aws_default_region
  profile = var.aws_profile
}

provider "lacework" {
  profile = "default"
}