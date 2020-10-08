resource "google_compute_instance" "fermier" {
	name         = "fermier"
	machine_type = "f1-micro"
	zone         = "us-central1-a"

	boot_disk {
		initialize_params {
			image = "ubuntu-os-cloud/ubuntu-2004-lts"
		}
	}

	network_interface {
		network = "default"

		access_config {
		}
	}
}
