terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 5.53"
      }
    }

    required_version = ">= 1.2.8"
}

provider "aws" {
  region  = "us-east-1"
  access_key = getenv("ACCESS_KEY") 
  secret_key = getenv("SECRET_KEY")
}
