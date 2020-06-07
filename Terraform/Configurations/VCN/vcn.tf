resource "oci_core_vcn" "terraformVCN" {
    cidr_block              = "10.0.0.0/16"
    dns_label               = "terraform-vcn"
    compartment_id          = var.compartment_id
    display_name            = "terraform-vcn"
}