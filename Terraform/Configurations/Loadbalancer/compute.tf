variable "ssh_public_key" {}
variable "ssh_private_key" {}

variable "instance_shape" {
  default = "VM.Standard2.1"
}

variable "instance_ocpus" {
  default = 1
}

variable "instance_image_ocid" {
  type = map

  default = {
    # See https://docs.us-phoenix-1.oraclecloud.com/images/
    # Oracle-provided image "Oracle-Linux-7.5-2018.10.16-0"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaaoqj42sokaoh42l76wsyhn3k2beuntrh5maj3gmgmzeyr55zzrwwa"

    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaageeenzyuxgia726xur4ztaoxbxyjlxogdhreu3ngfj2gji3bayda"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaitzn6tdyjer7jl34h2ujz74jwy5nkbukbh55ekp6oyzwrtfa4zma"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaa32voyikkkzfxyo4xbdmadc2dmvorfxxgdhpnk6dw64fa3l4jh7wa"
  }
}

variable "db_size" {
  default = "50" # size in GBs
}

data "oci_core_vcns" "terraformVCN" {
    compartment_id      = var.compartment_ocid
    display_name        = "terraformVCN"
}

data oci_core_subnets "PubSubnet"{
    compartment_id          = var.compartment_ocid
    vcn_id                  = data.oci_core_vcns.terraformVCN.virtual_networks[0].id
    display_name            = "PublicSubnet"
}

data "oci_identity_availability_domains" "ad" {
  compartment_id = "${var.tenancy_ocid}"
}


resource "oci_core_instance" "web"{
    count = var.mycount
    availability_domain = data.oci_identity_availability_domains.ad.availability_domains[count.index].name
    compartment_id      = var.compartment_ocid
    display_name        = "web${count.index}"
    shape               = var.instance_shape

    shape_config {
        ocpus = var.instance_ocpus
    }
    create_vnic_details {
        subnet_id        = data.oci_core_subnets.PubSubnet.subnets[0].id
        display_name     = "Primaryvnic"
        assign_public_ip = true
        hostname_label   = "web${count.index}"
    }
    source_details {
        source_type = "image"
        source_id   = var.instance_image_ocid[var.region]
    }
    metadata = {
        ssh_authorized_keys = var.ssh_public_key
    }
    timeouts {
        create = "60m"
    }
}

resource "null_resource" "http_deploy"{
    count = var.mycount
    provisioner "remote-exec" {
    connection {
      agent       = false
      timeout     = "30m"
      host        = oci_core_instance.web[count.index].public_ip
      user        = "opc"
      private_key = var.ssh_private_key
    }

    inline = [
        "echo 'This instance was provisioned by Terraform.' | sudo tee /etc/motd",
        "sudo yum -y install httpd",
        "echo \"This is index page in $(hostname)\" | sudo tee -a /var/www/html/index.html",
        "sudo firewall-cmd --permanent --add-service=http",
        "sudo firewall-cmd --reload",
        "sudo systemctl start httpd",
       "sudo systemctl enable httpd"
    ]
  }
}