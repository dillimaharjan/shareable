output "instance_public_ips" {
  value = [oci_core_instance.web.*.public_ip]
}