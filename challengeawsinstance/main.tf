provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "ec2" {
    ami = "ami-0022f774911c1d690"
    instance_type = "t2.micro"
}

resource "aws_eip" "elasticip" {
    instance = aws_instance.ec2.id
  
}

output "EIP" {
    value = aws_eip.elasticip.public_ip
}