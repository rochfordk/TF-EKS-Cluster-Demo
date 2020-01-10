remote_state {
  backend = "s3"
  config = {
    bucket = "kr-tf-state"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    #encrypt        = true
    #dynamodb_table = "my-lock-table"
  }
}