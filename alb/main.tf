module "sg"{
    source = "../sg"
}

module "vpc"{
    source = "../vpc"
}

resource "aws_lb" "mcc2_nvc_lb" {
  name               = "mcc2-nvc-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.sg.sg_alb_id]
  subnets            = [module.vpc.subnet_public_id]

  enable_deletion_protection = true
}