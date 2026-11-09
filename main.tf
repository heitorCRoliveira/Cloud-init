terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Busca a imagem (AMI) mais recente do Ubuntu 22.04 LTS
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# Cria um Security Group liberando portas 80 (HTTP) e 22 (SSH)
resource "aws_security_group" "web_sg" {
  name        = "sg_web_server"
  description = "Permitir HTTP e SSH"

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

# Cria a instância EC2
resource "aws_instance" "web_server" {
  ami                    = "ami-020ba0ae8c230ae28"
  instance_type          = "t3.micro" # Elegível ao Free Tier
  vpc_security_group_ids = [974443623508]

  # Entrega do arquivo Cloud-Init
  user_data = file("${path.module}/user-data.yaml")

  tags = {
    Name = "VM-CloudInit-CI-CD"
  }
}