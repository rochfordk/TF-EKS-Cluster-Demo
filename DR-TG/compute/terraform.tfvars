

terragrunt = {
  terraform = {
    #source  = "terraform-aws-modules/vpc/aws"
    source = "github.com:terraform-aws-modules/terraform-aws-eks?ref=v7.0.1"
    #source = "git:github.com/terraform-aws-modules/terraform-aws-vpc"
    #version = "2.6.0"
  }
}

inputs = {
    #region = "eu-west-1"
      cluster_name = "eks-cluster-1"
    #subnets      = data.terraform_remote_state.vpc.outputs.public_subnets
    #vpc_id       = data.terraform_remote_state.vpc.outputs.vpc_id

  worker_groups = [
    {
      name                = "on-demand-1"
      instance_type       = "m4.large"
      asg_max_size        = 1
      autoscaling_enabled = true
      kubelet_extra_args  = "--node-labels=spot=false"
      suspended_processes = ["AZRebalance"]
    },
    {
      name                = "spot-1"
      spot_price          = "0.199"
      instance_type       = "c4.xlarge"
      asg_max_size        = 2
      autoscaling_enabled = true
      kubelet_extra_args  = "--node-labels=kubernetes.io/lifecycle=spot"
      suspended_processes = ["AZRebalance"]
    },
    {
      name                = "spot-2"
      spot_price          = "0.20"
      instance_type       = "m4.xlarge"
      asg_max_size        = 2
      autoscaling_enabled = true
      kubelet_extra_args  = "--node-labels=kubernetes.io/lifecycle=spot"
      suspended_processes = ["AZRebalance"]
    }
  ]

  // TODO: Try using the recently added launch template support
  /*worker_groups_launch_template = [
    {
      name                    = "spot-1"
      override_instance_types = ["m5.large", "m5a.large", "m5d.large", "m5ad.large"]
      spot_instance_pools     = 4
      asg_max_size            = 3
      asg_desired_capacity    = 3
      kubelet_extra_args      = "--node-labels=kubernetes.io/lifecycle=spot"
      public_ip               = true
    },
  ]*/

  tags = {
    environment = "staging"
  }
}