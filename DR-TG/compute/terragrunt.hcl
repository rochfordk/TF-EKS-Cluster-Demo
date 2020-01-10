include {
  path = find_in_parent_folders()
}  

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  subnets = dependency.vpc.outputs.public_subnets
  vpc_id = dependency.vpc.outputs.vpc_id
}