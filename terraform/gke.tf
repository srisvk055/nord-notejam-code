## container_cluster
resource "google_container_cluster" "primary" {
  name                     = "nord-project-cluster"
  location                 = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.main.self_link
  subnetwork               = google_compute_subnetwork.private.self_link
  #  logging_service          = "logging.googleapis.com/kubernetes"   enable if required it is not free 
  #  monitoring_service       = "monitoring.googleapis.com/kubernetes"  enable if required it is not free 
  networking_mode = "VPC_NATIVE"

  # Optional, if you want multi-zonal cluster
  node_locations = [
    "us-central1-b"
  ]

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "nord-project.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
}

## google_service_account
resource "google_service_account" "sa-nord-k8s" {
  account_id = "sa-nord-k8s"
}

## Node pool Primary 
resource "google_container_node_pool" "general" {
  name       = "nord-project-general"
  cluster    = google_container_cluster.primary.id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = "e2-small"

    labels = {
      role = "general"
    }

    service_account = google_service_account.sa-nord-k8s.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

## Spot Node pool

resource "google_container_node_pool" "spot" {
  name    = "nord-project-spot"
  cluster = google_container_cluster.primary.id

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 0
    max_node_count = 10
  }

  node_config {
    preemptible  = true
    machine_type = "e2-small"

    labels = {
      team = "nord"
    }

    taint {
      key    = "instance_type"
      value  = "spot"
      effect = "NO_SCHEDULE"
    }

    service_account = google_service_account.sa-nord-k8s.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}