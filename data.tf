data "google_projects" "main" {
	filter = "parent.id:devoir-1-cr460-290803"
}

output "project" {
	value 	= data.google_projects.main
}

data "google_compute_network" "default" {
	name 	= "devoir1"
	project = "$data.google_projects.main" #var.project-name
}

output "devoir1" {
	value 	= data.google_compute_network.devoir1
}