
resource "google_compute_instance" "progressions" {
  project      = var.project_id
  zone         = var.zone
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
    network = "default"

    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  tags = ["http-server", "https-server"]

  metadata = {
      startup-script = file("${path.module}/scripts/init.sh")
      ssh-keys       = "root:${file("${var.public_key_path}")}"
    }

  service_account {
    email  = var.service_account_email
    scopes = [
        "https://www.googleapis.com/auth/compute.readonly",
    ]
  }

  depends_on = [google_compute_address.static]

}

