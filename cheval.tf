resource "google_compute_instance" "cheval" {
	name         = "cheval"
	machine_type = "f1-micro"
	zone         = "us-central1-a"
	tags         = ["public"]

	boot_disk {
		initialize_params {
		image = "fedora-coreos-cloud/fedora-coreos-stable"
		}
	}

	network_interface {
		subnetwork = google_compute_subnetwork.prod-traitement.name

		access_config {
		}
	}
	metadata_startup_script = "sudo dnf -y update && sudo dnf -y upgrade && sudo dnf install -y openssh-server && sudo systemctl start sshd.service && sudo systemctl enable sshd.service"
}