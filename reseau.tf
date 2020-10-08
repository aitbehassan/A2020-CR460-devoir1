#resource "google_compute_network" "devoir1" {
#	name                    	= "devoir1"
#	auto_create_subnetworks 	= "false"
#}

resource "google_compute_subnetwork" "prod-interne" {
  name          = "prod-interne"
  ip_cidr_range = "10.0.3.0/24"
  region        = "us-central1"
  network       = "$data.google_compute_network.devoir1"
}

resource "google_compute_subnetwork" "prod-traitement" {
  name          = var.prod-traitement
  ip_cidr_range = "10.0.2.0/24"
  region        = "us-central1"
  network       = "$data.google_compute_network.devoir1"
}

resource "google_compute_subnetwork" "prod-dmz" {
  name          = "prod-dmz"
  ip_cidr_range = "172.16.3.0/24"
  region        = "us-central1"
  network       = "$data.google_compute_network.devoir1"
}
