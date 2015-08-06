provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

resource "aws_ebs_volume" "workspace_disk" {
   availability_zone = "us-east-1a"
   size = 10
   tags {
       Name = "workspace_disk"
   }
}

resource "aws_instance" "workspace_instance" {
    ami = "ami-3fee3b54" #BOSH lite 9000.38
    instance_type = "m3.medium"
    key_name = "${var.workspace_key_name}"
    tags {
        Name = "workspace_instance"
    }

    subnet_id = "${var.workspace_subnet_id}"
    vpc_security_group_ids = ["${var.workspace_security_group_id0}", "${var.workspace_security_group_id1}", "${var.workspace_security_group_id2}"]
    
    associate_public_ip_address = "true"

    root_block_device {
      volume_type = "gp2"
      volume_size = 10
    }

}

resource "aws_volume_attachment" "workspace_ebs_att" {
    device_name = "/dev/sdf"
    volume_id = "${aws_ebs_volume.workspace_disk.id}"
    #instance_id = "${aws_spot_instance_request.workspace_instance.spot_instance_id}"
    instance_id = "${aws_instance.workspace_instance.id}"

    provisioner "remote-exec" {
        script = "provision.sh"
        connection {
          host = "${aws_instance.workspace_instance.public_ip}"
          user = "ubuntu"

        }
    }
}


#resource "aws_spot_instance_request" "workspace_instance" {
#    ami = "ami-3fee3b54" #BOSH lite 9000.38
#    instance_type = "m3.xlarge"
#    spot_price = "0.15"
#
#    subnet_id = "${var.workspace_subnet_id}"
#
#    wait_for_fulfillment = true
#    key_name = "${var.workspace_key_name}"
#    tags {
#        Name = "workspace_instance"
#    }
#
#    root_block_device {
#      volume_type = "gp2"
#      volume_size = 100
#    }
#}
#
#resource "aws_network_interface" "workspace_instance_network_interface" {
#    subnet_id = "${var.workspace_subnet_id}"
#    security_groups = ["${var.workspace_security_group_id0}", "${var.workspace_security_group_id1}", "${var.#workspace_security_group_id2}"]
#    attachment {
#        instance = "${aws_spot_instance_request.workspace_instance.spot_instance_id}"
#        device_index = 1
#    }
#    tags {
#        Name = "workspace_instance"
#    }
#}
#
#
#resource "aws_eip" "workspace_instance_public_ip" {
#    network_interface = "${aws_network_interface.workspace_instance_network_interface.id}"
#
#    vpc = true
#    
#    provisioner "remote-exec" {
#        script = "provision.sh"
#        connection {
#          host = "${aws_eip.workspace_instance_public_ip.public_ip}"
#          user = "ubuntu"
#          key_file = "${var.workspace_key_file}"
#        }
#    }
#
#}





