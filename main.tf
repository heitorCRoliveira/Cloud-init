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



# Cria a instância EC2
resource "aws_instance" "web_server" {
  ami           = "ami-0ee52710c51e09069"
  instance_type = "t3.micro"
  # Linha vpc_security_group_ids removida para usar o Default SG
  
  user_data = file("${path.module}/user-data.yaml")

  tags = {
    Name = "VM-CloudInit-CI-CD"
  }
}