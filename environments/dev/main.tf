module "vpc" {
  source = "../../modules/vpc"
}

module "ec2" {
  source = "../../modules/ec2"
  allow_ssh = false //moduleのvariables
  subnet_id = module.vpc.public_subnet_id //moduleのoutputs
}
