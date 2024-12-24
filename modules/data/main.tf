
// ---------------------------------------------------- COMPUTE SERVER + DOCKER + POSTGRESQL  -- //
// ---------------------------------------------------- ------------------------------------- -- //

resource "google_compute_instance" "dbm_postgresql_instance" {
  name         = var.dbm_instance_name
  machine_type = var.dbm_instance_tier
  zone         = var.prj_region

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = var.vpc_id
    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    gce-container-declaration = <<EOF
spec:
  containers:
    - image: 'docker.io/iteralabs/datalake-web3-postgreSQL:latest'
      name: docker-container
      stdin: false
      tty: false
  restartPolicy: Always
EOF
  }

  service_account {
    scopes = ["cloud-platform"]
  }

  tags = ["docker-instance"]
}


// -------------------------------------------------------------------------------- DATA BASE -- //
// -------------------------------------------------------------------------------- --------- -- //

resource "google_sql_database" "dbm_data_lake" {
  name     = var.dbm_name
  instance = google_sql_database_instance.dbm_data_lake_instance.name
  
}

