resource "google_compute_instance" "canard" {
  name         = "canard"
  machine_type = "f1-micro"
  zone         = "us-central1-a"
  tags         = ["web"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
     }
   }

   network_interface {
    subnetwork = google_compute_subnetwork.prod-dmz.name

      access_config {
      }
   }
   metadata_startup_script = "sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get install apache2 -y && sudo systemctl start apache2 && sudo systemctl enable apache2"
}

resource "google_compute_firewall" "fw1-canard" {
  name 			= "canard-fw-1"
  network 		= "$data.google_compute_network.devoir1"
  source_ranges = ["0.0.0.0/0"]
  target_tags 	= ["web"]
  allow {
    protocol 	= "tcp"
    ports 		= ["80"]
  }
  allow {
    protocol 	= "tcp"
    ports 		= ["22"]
  }
  direction = "INGRESS"
}
