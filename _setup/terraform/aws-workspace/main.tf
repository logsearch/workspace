provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

resource "aws_spot_instance_request" "workspace_instance" {
    ami = "ami-3fee3b54" #BOSH lite 9000.38
    instance_type = "m3.xlarge"
    spot_price = "0.15"

    wait_for_fulfillment = true
    key_name = "${var.workspace_key_name}"
    tags {
        Name = "workspace_instance"
    }

    subnet_id = "${var.workspace_subnet_id}"
    #vpc_security_group_ids = ["${var.workspace_security_group_id0}", "${var.workspace_security_group_id1}", "${var.workspace_security_group_id2}"]

    root_block_device {
      volume_type = "gp2"
      volume_size = 100
    }

    provisioner "remote-exec" {
        script = "provision.sh"
        connection {
          user = "ubuntu"
        }
    }
}

resource "aws_ebs_volume" "workspace_disk" {
   availability_zone = "us-east-1a"
   size = 40
   tags {
       Name = "workspace_disk"
   }
}

resource "aws_volume_attachment" "workspace_ebs_att" {
    device_name = "/dev/sdf"
    volume_id = "${aws_ebs_volume.workspace_disk.id}"
    instance_id = "${aws_spot_instance_request.workspace_instance.spot_instance_id}"
}