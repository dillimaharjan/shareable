resource "oci_core_internet_gateway" "terraformIGW" {
    compartment_id              = var.compartment_ocid
    display_name                = "terraformIGW"
    vcn_id                      = data.oci_core_vcns.terraformVCN.virtual_networks[0].id
}