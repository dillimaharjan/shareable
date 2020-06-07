resource "oci_core_vcn" "terraformVCN" {
    cidr_block              = "10.0.0.0/16"
    dns_label               = "terraformVCN"
    compartment_id          = var.compartment_ocid
    display_name            = "terraformVCN"
}