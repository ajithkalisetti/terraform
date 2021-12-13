terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
variable "ip" {
  type = string
  default = "190.10.0.0/20"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "main" {
  cidr_block = "190.10.0.0/16"
  tags = {
    Name = "Thala"
  }
}
resource "aws_subnet" "subnet1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.ip}"


  tags = {
    Name = "subnet1"
  }
}
