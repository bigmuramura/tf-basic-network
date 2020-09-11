provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  backend "s3" {
    bucket = "tf-backend-ohmura"
    key    = "tf-basic-network/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
