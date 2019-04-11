output "app_subnet" {
    value = "${module.vpc.subnets_self_links[0]}"
}
