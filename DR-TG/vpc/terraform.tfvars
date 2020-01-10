

terragrunt = {
  terraform = {
    #source  = "terraform-aws-modules/vpc/aws"
    source = "github.com:terraform-aws-modules/terraform-aws-vpc?ref=v2.6.0"
    #source = "git:github.com/terraform-aws-modules/terraform-aws-vpc"
    #version = "2.6.0"
  }
} 




inputs = {
    region = "eu-west-1"
    name = "stage-eks-cluster1-vpc"

    cidr = "10.0.0.0/16"
    azs             = ["eu-west-1a", "eu-west-1b"]
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