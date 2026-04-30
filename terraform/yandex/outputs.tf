output "vm_public_ip" {
  value = yandex_compute_instance.caliman_vm.network_interface.0.nat_ip_address
}

output "vm_internal_ip" {
  value = yandex_compute_instance.caliman_vm.network_interface.0.ip_address
}