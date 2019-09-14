terraform {
  backend "remote" {
    organization = "quark"

    workspaces {
      prefix = "terraform-example-"
    }
  }
}

provider "aws" {
  version = "~> 2.28"
  profile = "default"
  region  = "${var.region}"
}

resource "aws_instance" "example" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
}

resource "aws_eip" "ip" {
  vpc      = true
  instance = "${aws_instance.example.id}"
}

output "ami_id" {
  value = "${aws_instance.example.ami}"
}
output "ip" {
  value = "${aws_eip.ip.public_ip}"
}

