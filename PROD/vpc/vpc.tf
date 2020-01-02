##################################################################
# VPC for EKS Cluster
# Amazon EKS requires subnets in at least two Availability Zones. 
# A network architecture that uses private subnets for the worker nodes and public subnets for Kubernetes to create internet-facing load balancers is is recommended.
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.17.0
##################################################################

provider "aws" {
  region  = var.region
}

terraform {
  backend "s3" {
    # bucket name for remote state - NB: no locking
    bucket         = "kr-tf-state"
    key            = "stage/eks-cluster-1/vpc/terraform.tfstate"
    region         = "eu-west-1"
  }
}

module "vpc"{
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.6.0"

  name = "stage-eks-cluster1-vpc"

  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  // azs                  = data.aws_availability_zones.available.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_dns_hostnames = true
  
  tags = {
    Owner       = "rochford"
    Environment = "stage"
    Pipeline = "tbd"
  }

  vpc_tags = {
    Name = "stage-eks-cluster1-vpc"
  }
}
