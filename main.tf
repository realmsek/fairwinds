terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.55.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "eu-west=3"
  access_key = "AKIAU5TAEY3L2XPPHZRG"
  secret_key = "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"
}

#resource "" "name" {
#    config options...
#    key = "value"
#}


resource "aws_instance" "fw-app" {
  ami           = var.ami
  instance_type = var.instance_type

  network_interface {
    network_interface_id = var.network_interface_id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}

variable "network_interface_id" {
  type = string
  default = "network_id_from_aws"
}

variable "ami" {
    type = string
    default = "ami-005e54dee72cc1d00"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}