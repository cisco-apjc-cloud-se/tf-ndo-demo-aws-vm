terraform {
  // experiments = [module_variable_optional_attrs]
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "mel-ciscolabs-com"
    workspaces {
      name = "tf-ndo-demo-aws-vm"
    }
  }
  required_providers {
    vault = {
      source = "hashicorp/vault"
      # version = "2.18.0"
    }
    aws = {
      source = "hashicorp/aws"
      # version = "3.25.0"
    }
  }
}

### Setup AWS Provider ###

provider "aws" {
  region     = "ap-southeast-2"
  access_key = data.vault_generic_secret.aws-prod.data["access"]
  secret_key = data.vault_generic_secret.aws-prod.data["secret"]
}

## Build Test EC2 Instance(s) ##
module "aws" {
  source = "./modules/aws"

  tenant          = var.tenant
  aws_apps        = var.aws_apps
  instance_type   = "t3a.micro"
  public_key      = var.public_key

  depends_on = [
    module.ndo
  ]
}
