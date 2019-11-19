##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {
  default = "terraform"
}

##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "eu-west-1"
}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_instance" "nginx" {
  ami                    = "ami-040ba9174949f6de4"
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.for_terraform.id]
  tags={
  name="teraform_server"}
  user_data = file("user_data.sh")


}

resource "aws_security_group" "for_terraform" {
  name        = "for_terraform"
  description = "Allow HTTP inbound traffic"


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
