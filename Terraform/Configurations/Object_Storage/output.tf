output "ObjectBuckerPreAuthURL"{
    value = "https://objectstorage.${var.region}.oraclecloud.com${oci_objectstorage_preauthrequest.terraformPreAuth.access_uri}"
}
