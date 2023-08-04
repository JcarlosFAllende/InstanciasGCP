# Define el proveedor GCP
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.73.1"
    }
  }
}

provider "google" {
  project = "curso-ccp-2023"
  region  = "us-central1"
  credentials = "./curso-ccp-2023-ffd8b389c06c.json"
}

resource "google_compute_instance" "instance-1" {
  machine_type = "e2-medium"
  name         = "instance-1"
  zone  = "us-central1-c"

  boot_disk {
    auto_delete = true
    device_name = "instance-1"

    initialize_params {
      image = "projects/debian-cloud/global/images/debian-11-bullseye-v20230629"
      size  = 10
      type  = "pd-balanced"
      
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }


  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "projects/curso-ccp-2023/regions/us-central1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }


  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  
  //metadata_startup_script = "echo h1 > /test.txt"
}




