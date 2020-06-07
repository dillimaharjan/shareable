resource "oci_core_default_route_table" "terraforRT"{
    manage_default_resource_id  = data.oci_core_vcns.terraformVCN.virtual_networks[0].default_route_table_id
    display_name                = "defaultRouteTable"

    route_rules {
        destination             = var.anywhere
        destination_type        = "CIDR_BLOCK"
        network_entity_id       = oci_core_internet_gateway.terraformIGW.id
    }
}