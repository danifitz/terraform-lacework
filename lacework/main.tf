terraform {
  required_providers {
    lacework = {
      source = "lacework/lacework"
      version = "0.17.0"
    }
  }
}

provider "lacework" {
  profile = "default"
}
