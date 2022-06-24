## Provider 
provider "google" {
  project = "nord-project"
  region  = "us-central1"
}

terraform {
  backend "gcs" {
    bucket = "nord-project-gke-tf"
    prefix = "terraform/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0.0"
    }
  }
}