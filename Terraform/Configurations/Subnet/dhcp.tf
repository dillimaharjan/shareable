resource "oci_core_default_dhcp_options" "default_dhcp_options" {
    manage_default_resource_id  = data.oci_core_vcns.terraformVCN.virtual_networks[0].default_dhcp_options_id
    display_name                = "defaultDHCPOptions"

    // required
    options {
        type                    = "DomainNameServer"
        server_type             = "VcnLocalPlusInternet"
    }

    // optional
    options {
        type                    = "SearchDomain"
        search_domain_names      = ["abc.com"]
    }

}