resource "oci_core_nat_gateway" "terraformNAT" {
    compartment_id          = var.compartment_ocid
    display_name            = "terraformNAT"
    vcn_id                  = data.oci_core_vcns.terraformVCN.virtual_networks[0].id
}