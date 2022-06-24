## Provider 
provider "google" {
  project = "nord-project"
  region  = "us-central1"
}
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0.0"
    }
  }
}