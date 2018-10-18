############## Input from the Deployer

variable "owner" {
  description = "Owner Name"
}
variable "owner_email" {
  description = "Owner Email"
}

variable "environment" {
  description = "The name of the environment"
  default = "development"
}

variable "dso_domain" {
  default = "dsolab.net"
  description = "DSO Domain name"
}

variable "zone_id" {
 default = "/hostedzone/Z2KBAPVGPRZ50I"
 description = "Zone ID of the Domain"
}

variable "arn_acme" {
  default = "arn:aws:acm:us-east-1:757687274468:certificate/f5b34366-54c1-4814-bd9b-6a9a650238d9"
  description = "certificate arn"
}

variable "sde_ami" {
  default = "ami-0e57e5a9c42df1a5e"
  description = "SDE default AMI"
}

variable "sde_version" {
  default = "sde dso"
  description = "Name of the version for the SDE"
}

############### Input from the LAB stack



variable "short_env" {
  type = "map"

  default = {
    production = ""
    development = "-sde"
  }
}

variable "key_name" {
  type = "map"

  default = {
    production = "dso-prod-10102018"
    development = "dso-dev-09102018"
  }
}

variable "sde_ssm_pass" {
  type = "map"

  default = {
    production = "/prod/sde/pass"
    development = "/dev/sde/pass"
  }
}

variable "sde_ssm_user" {
  type = "map"

  default = {
    production = "/prod/sde/user"
    development = "/dev/sde/user"
  }
}


variable "sg_id" {
  default = "sg-0961c3da3977a5a7c"
  description = "Security group"
}

variable "vpc_id" {
  default = "vpc-082f1b56314869494"
  description = "VPC"
}

variable "public_subnets" {
  default = ["subnet-004db3a8b97237878", "subnet-07b0dc9a6cc857aa7"]
  type = "list"
  description = "Public subnets"
}

variable "subnet_id" {
  default = "subnet-004db3a8b97237878"
  description = "subnet"
}

############## TODO

variable "ecs_instance_profile" {
  default = "iam_instance_profile_"
  description = "ECS Role Name"
}

variable "aws_region" {
  default = "us-east-1"
  description = "AWS region"
}

variable "s3_bucket" {
  default = "dso-lab-2018appseco"
  description = "S3 bucket where remote state and Jenkins data will be stored."
}

##########################

variable "instance_type" {
  default = "t2.medium"
  description = "Ec2 instance for the ECS"
}
