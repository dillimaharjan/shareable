variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "compartment_ocid" {}
variable "anywhere" {
    default = "0.0.0.0/0"
}
variable mycount {
    default = 3
}