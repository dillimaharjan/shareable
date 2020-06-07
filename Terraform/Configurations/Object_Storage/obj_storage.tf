resource oci_objectstorage_bucket "terrformBucker"{
    compartment_id      = var.compartment_ocid
    namespace           = var.namespace
    name                = "terraformBucket"
    access_type         = "NoPublicAccess"
}

resource "oci_objectstorage_preauthrequest" "terraformPreAuth"{
    access_type         = "AnyObjectWrite"
    bucket              = "terraformBucket"
    name                = "terraformPreAuth"
    namespace           = var.namespace
    time_expires        = "2020-08-01T00:00:00.000+00:00"
}