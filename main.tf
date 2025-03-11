provider "aws" {
  region = "us-east-1"  # Specify your region
}

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_instance" "ec2_instance" {
  ami           = "ami-032a56ad5e480189c"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
  key_name      = "MyKeyPair"  # Replace with your key pair name
  security_groups = [aws_security_group.allow_ssh_http.name]
  
  tags = {
    Name = "MyEC2Instance"
  }
}

output "ec2_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}
