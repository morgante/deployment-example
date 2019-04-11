module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "0.6.0"

  project_id   = "${var.host_project}"
  network_name = "prod-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "prod-subnet-01"
      subnet_ip     = "10.20.10.0/24"
      subnet_region = "us-west1"
    }
  ]

  secondary_ranges = {
    prod-subnet-01 = []
  }
}

module "shared-rules" {
  source = "../../../modules/shared_fw_rules"

  network      = "${module.vpc.network_name}"
  host_project = "${var.host_project}"
}
