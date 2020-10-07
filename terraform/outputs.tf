output "external_ip_address_app" {
    value = yandex_compute_instance.app[*].network_interface.0.nat_ip_address
}

output "load_balancer_address" {
    value = yandex_lb_network_load_balancer.lb-reddit-app.listener.*.external_address_spec[0].*.address
}
