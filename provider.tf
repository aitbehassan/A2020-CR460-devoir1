provider "google" {
	credentials = file("service-account.json")
	version 	= "3.5.0"
	project 	= var.project-name
	region 		= var.region
	zone 		= var.zone
}
