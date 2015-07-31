provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

resource "aws_ebs_volume" "BoshDisk" {
   availability_zone = "us-east-1a"
   size = 40
   tags {
       Name = "Bosh"
   }
}

resource "aws_spot_instance_request" "MicroBoshTest" {
    spot_price = "0.03"
    wait_for_fulfillment = true
    availability_zone = "us-east-1a"
    ami = "ami-3fee3b54"
    instance_type = "m3.medium"
    tags {
        Name = "Bosh"
    }
}

resource "aws_volume_attachment" "ebs_att" {
    device_name = "/dev/sdh"
    volume_id = "${aws_ebs_volume.BoshDisk.id}"
    instance_id = "${aws_spot_instance_request.MicroBoshTest.spot_instance_id}"
}