provider "aws" {
    region = "us-east-1"
}

variable "ingressrules" {
    type = list(number)
    default = [ 80,443 ]
}

variable "egressrules" {
    type = list(number)
    default = [ 80,443,25,3306,53,8080 ]
}

resource "aws_instance" "ec2" {
    ami = "ami-0022f774911c1d690"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.terraformSG1.name]
}

resource "aws_security_group" "terraformSG1" {
    name = "Allow HTTPS"
  
  dynamic "ingress" {
      iterator = port
      for_each = var.ingressrules
      content {
              cidr_blocks = [ "0.0.0.0/0" ]
                from_port = port.value
                protocol = "tcp"
                to_port = port.value
      }

  } 

    dynamic "egress" {
        iterator = port
        for_each = var.egressrules
        content {
                cidr_blocks = [ "0.0.0.0/0" ]
                    from_port = port.value
                    protocol = "tcp"
                    to_port = port.value
        }
    }
}