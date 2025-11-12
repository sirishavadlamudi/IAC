# 1. Configure the Google Provider

terraform {

  required_providers {

    google = {

      source  = "hashicorp/google"

      version = "~> 5.0" # Use a recent version of the GCP provider

    }

  }
 
  required_version = ">= 1.3.0"

}
 
provider "google" {

  project = "sirisha-test1"        # 🔹 Replace with your actual GCP project ID

  region  = "us-central1"     # 🔹 Default region for regional resources

  zone    = "us-central1-a"   # 🔹 Default zone for zonal resources

}
 
# 2. Define the Compute Instance Resource

resource "google_compute_instance" "default_vm" {

  name         = "terraform-vm"  # VM name

  machine_type = "e2-micro"          # VM type

  zone         = "us-central1-a"      # Zone to deploy in
 
  # Define the boot disk image (Debian 12 recommended)

  boot_disk {

    initialize_params {

      image = "projects/debian-cloud/global/images/family/debian-12"

      size  = 10

      type  = "pd-balanced"

    }

  }
 
  # Attach the instance to the default VPC

  network_interface {

    network       = "default"

    access_config {} # Required to get an external IP (for SSH)

  }
 
  # Optional: Add instance metadata (for SSH access or OS Login)

  metadata = {

    enable-oslogin = "FALSE"

  }
 
  tags = ["terraform-vm"]

}
 
# 3. Output the created resource details

output "instance_name" {

  value = google_compute_instance.default_vm.name

}
 
output "instance_zone" {

  value = google_compute_instance.default_vm.zone

}
 
output "instance_public_ip" {

  value = google_compute_instance.default_vm.network_interface[0].access_config[0].nat_ip

}

 