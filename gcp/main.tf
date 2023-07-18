terraform {
  required_providers {
    lacework = {
      source = "lacework/lacework"
      version = "~> 1.8.0"
    }
  }
}

provider "google" {
  credentials = file("danf-cloud-run-test-682519676c78.json")
  project     = "danf-cloud-run-test"
}

provider "google" {
  alias = "dan-test-project"
  credentials = file("dan-lw-alert-test-project-31dc00efe22f.json")
  project = "dan-lw-alert-test-project"
}

provider "google" {
  alias = "pubsub-audit-log"
  credentials = file("lacework-gcp-pubsub-auditlog-15fb03f92553.json")
  project = "lacework-gcp-pubsub-auditlog"
}

provider "lacework" {}

module "gcp_project_config" {
  source  = "lacework/config/gcp"
  version = "~> 2.4.3"
}

module "gcp_project_config-dan-test" {
  source = "lacework/config/gcp"
  version = "~> 2.4.3"
  providers = {
    google = google.dan-test-project
  }
}

module "gcp_project_config-pubsub-audit-log" {
  source = "lacework/config/gcp"
  version = "~> 2.4.3"
  providers = {
    google = google.pubsub-audit-log
  }
}

module "gcp_project_audit_log" {
  source  = "lacework/audit-log/gcp"
  version = "~> 3.4.3"
  
  bucket_force_destroy         = true
  use_existing_service_account = true
  service_account_name         = module.gcp_project_config.service_account_name
  service_account_private_key  = module.gcp_project_config.service_account_private_key
}

module "gcp_project_audit_log-dan-test" {
  source  = "lacework/audit-log/gcp"
  version = "~> 3.4.3"
  providers = {
    google = google.dan-test-project
  }
  
  bucket_force_destroy         = true
  use_existing_service_account = true
  service_account_name         = module.gcp_project_config.service_account_name
  service_account_private_key  = module.gcp_project_config.service_account_private_key
}

# new pubsub audit log integration
module "gcp_organization_level_pub_sub_audit_log" {
  source           = "lacework/pub-sub-audit-log/gcp"
  version          = "~> 0.2.2"
  providers = {
    google = google.pubsub-audit-log
  }
  
  integration_type = "PROJECT"
}