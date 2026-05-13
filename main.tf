provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "sgtf" {
  name        = "sgterraform"
  description = "allow for ssh"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_ec2" {
  ami                    = "ami-011cefff1c767b619"
  instance_type          = "t3.micro"
  key_name               = "chat"
  vpc_security_group_ids = [aws_security_group.sgtf.id]

  tags = {
    Name = "terrformEC2"
  }
}

resource "aws_s3_bucket" "demo" {
  bucket = "arydeep-demo"
}

output "public_ip" {
  value = aws_instance.my_ec2.public_ip
}
