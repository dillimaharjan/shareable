resource "oci_core_default_security_list" "default_security_list"{
    manage_default_resource_id  = data.oci_core_vcns.terraformVCN.virtual_networks[0].default_security_list_id
    display_name                = "defaultSecurityList"

    // allow outbout tcp traffic on all ports
    egress_security_rules {
        destination             = var.anywhere
        protocol                = "6"
    }

    // allow outbound udp traffic on port ranges
    egress_security_rules {
        destination             = var.anywhere
        protocol                = "17"
        stateless               = "true"

        udp_options {
            min = 319
            max = 320
        }
    }
    
    // allow inbound ssh traffic
    ingress_security_rules {
        protocol                = "6"
        source                  = var.anywhere
        stateless               = false

        tcp_options {
            min     = 22
            max     = 22
        }
    }
    
    // allow inbound http traffic
    ingress_security_rules {
        protocol                = "6"
        source                  = var.anywhere
        stateless               = false

        tcp_options {
            min     = 80
            max     = 80
        }
    }


    // allow inbound icmp traffic of a specific type
    ingress_security_rules {
        protocol    = 1
        source      = var.anywhere
        stateless   = true

        icmp_options {
            type    = 3
            code    = 4
        }
    }
    
}