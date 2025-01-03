
resource "google_compute_instance" "compute_instance" {
  
  project      = var.prj_project_id
  zone         = var.prj_zone
  name         = var.cmp_instance_name
  machine_type = var.cmp_instance_type

  boot_disk {
    initialize_params {
      image = var.cmp_instance_image
      size = 20
      type = "pd-ssd"
    }
  }

  network_interface {
    subnetwork = var.cmp_subnet_id
  }

  metadata = {
    ssh-keys = var.cmp_instance_ssh
  }

  tags = ["http-server", "https-server"]

}

