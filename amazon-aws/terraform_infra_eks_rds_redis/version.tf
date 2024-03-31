# Terraform setting block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  #backend "s3" {
  # bucket         	   = "mycomponents-tfstate"
  # key              	 = "state/terraform.tfstate"
  # region         	   = "ap-south-1"
  # encrypt        	   = true
  #}
}

