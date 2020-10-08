resource "google_compute_instance" "mouton" {
  name         = "mouton"
  machine_type = "f1-micro"
  zone         = "us-central1-a"
  tags         = ["public"]

  boot_disk {
    initialize_params {
      image = "fedora-coreos-cloud/fedora-coreos-stable"
     }
   }

   network_interface {
    subnetwork = google_compute_subnetwork.prod-interne.name

      access_config {
      }
   }
   metadata_startup_script = "sudo dnf -y update && sudo dnf -y upgrade && sudo dnf install -y openssh-server && sudo systemctl start sshd.service && sudo systemctl enable sshd.service"
}

resource "google_compute_address" "static-prod-interne" {
  name = "ipv4-address"
}

resource "google_compute_firewall" "fw1-mouton" {
  name 			= "mouton-fw-1"
  network 		= "$data.google_compute_network.devoir1"
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol 	= "tcp"
    ports 		= ["22"]
  }
  target_tags 	= ["public"]
  direction 	= "INGRESS"
}

resource "google_compute_firewall" "fw2-mouton" {
  depends_on 	= [google_compute_firewall.fw1-mouton]
  name 			= "mouton-fw-2"
  network 		= "$data.google_compute_network.devoir1"
  source_ranges = ["10.0.3.0/24"]
  allow {
    protocol 	= "tcp"
	ports		= ["2846", "5462"]
  }
  target_tags 	= ["iana-access"]
  direction 	= "INGRESS"
}
