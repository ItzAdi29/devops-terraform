provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "private-sg" {
  name = "x21201188-my-SG"
  description = "HTTP and SSH traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my-EC2" {
  ami = "ami-01cae1550c0adea9c"
  instance_type = "t2.micro"
  key_name = "X21201188-AmzLinux"
  vpc_security_group_ids = [aws_security_group.private-sg.id]
  associate_public_ip_address = true
  root_block_device {
    volume_type = "gp2"
    volume_size = "8"
    delete_on_termination = true
  }
  tags = {
    Name = "x21201188-Test-EC2"
  }
}

resource "aws_s3_bucket" "test-bucket" {
  bucket = "x21201188-devops-tst-buck"
  acl    = "private"
  tags = {
    Name        = "devops-south-tst-buck"
  }
}
