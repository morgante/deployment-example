module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "0.6.0"

  project_id   = "${var.host_project}"
  network_name = "dev-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "dev-subnet-01"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    },
    {
      subnet_name           = "dev-subnet-02"
      subnet_ip             = "10.10.30.0/24"
      subnet_region         = "us-central1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
  ]

  secondary_ranges = {
    dev-subnet-01 = [
      {
        range_name    = "subnet-01-secondary-01"
        ip_cidr_range = "192.168.64.0/24"
      },
    ]

    dev-subnet-02 = []
  }
}

module "shared-rules" {
  source = "../../../modules/shared_fw_rules"

  network      = "${module.vpc.network_name}"
  host_project = "${var.host_project}"
}
