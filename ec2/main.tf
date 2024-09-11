module "vpc" {
  source = "../vpc"
}

module "sg" {
  source = "../sg"
}

resource "aws_instance" "public_instance"{
  ami = "ami-003932de22c285676" # ubuntu 22.04 LTS Free tier elegible
  instance_type = "t3.micro"
  subnet_id = module.vpc.subnet_public_id
  associate_public_ip_address = true
  security_groups = [module.sg.sg_public_ec2_id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              sudo systemctl start apache2
              sudo systemctl enable apache2
              EOF
}
resource  "aws_eip" "public_instance_eip" {
  instance = aws_instance.public_instance.id
  vpc = true
}

resource "aws_instance" "private_instance"{
    ami = "ami-003932de22c285676" # ubuntu 22.04 LTS Free tier elegible
    instance_type = "t3.micro"
    subnet_id = module.vpc.subnet_private_id
    security_groups = [module.sg.sg_private_ec2_id]
}
