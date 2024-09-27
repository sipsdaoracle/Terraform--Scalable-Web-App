module "ec2" {
  source         = "../../modules/ec2"
  ami_id         = "var.ami_id"
  instance_type  = "var.instance_type"
  instance_count = 2
  subnet_id      = "var.subnet_ids"
  instance_name  = "my-ec2"
}

module "elb" {
  source               = "../../modules/elb"
  elb_name             = "my-elb"
  subnets              = ["var.subnet_ids"]
  target_group_port    = 80
  target_group_protocol = "HTTP"
  vpc_id             = "vpc-05136f24b4b3ba92d"
}

module "asg" {
  source                   = "../../modules/asg"
  launch_configuration_name = "var.launch_configuration_name"
  depends_on = [ module.ec2 ]
  ami_id                    = "var.ami_id"
  instance_type             = "t2.micro"
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  subnets                   = ["subnet-01eec6539a0d7fb60", "subnet-0576208b268eb55e3", "subnet-0fc6489f885f11b3a"]
  target_group_arns         = [module.elb.target_group_arn]
  autoscaling_group_name    = "var.autoscaling_group_name"
}