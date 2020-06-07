data "oci_identity_availability_domain" "ad" {
  compartment_id = "${var.tenancy_ocid}"
  ad_number      = 1
}

data "oci_core_vcns" "terraformVCN" {
    compartment_id      = var.compartment_ocid
    display_name        = "terraformVCN"
}

resource "oci_core_subnet" "PublicSubnet"{
    cidr_block                  = "10.0.0.0/24"
    display_name                = "PublicSubnet"
    dns_label                   = "PublicSubnet"
    compartment_id              = var.compartment_ocid
    vcn_id                      = data.oci_core_vcns.terraformVCN.virtual_networks[0].id
    security_list_ids           = [data.oci_core_vcns.terraformVCN.virtual_networks[0].default_security_list_id]
    route_table_id              = data.oci_core_vcns.terraformVCN.virtual_networks[0].default_route_table_id
    dhcp_options_id             = data.oci_core_vcns.terraformVCN.virtual_networks[0].default_dhcp_options_id
}

resource "oci_core_subnet" "PrivateSubnet"{
    cidr_block                  = "10.0.1.0/24"
    display_name                = "PrivateSubnet"
    dns_label                   = "PrivateSubnet"
    compartment_id              = var.compartment_ocid
    vcn_id                      = data.oci_core_vcns.terraformVCN.virtual_networks[0].id
    security_list_ids           = [data.oci_core_vcns.terraformVCN.virtual_networks[0].default_security_list_id]
    route_table_id              = data.oci_core_vcns.terraformVCN.virtual_networks[0].default_route_table_id
    dhcp_options_id             = data.oci_core_vcns.terraformVCN.virtual_networks[0].default_dhcp_options_id
}