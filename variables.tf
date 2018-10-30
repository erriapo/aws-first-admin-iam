variable "aws_region" {
  default = "us-east-2"
}

variable "zone" { 
  default = "us-east-2b" 
}

# Customized in a `terraform.tfvars`
#variable "aws_pem_key_file_path" {}
#variable "aws_key_name" {}

# Customized in a `terraform.tfvars`
variable "aws_access_key" {}
variable "aws_secret_key" {}
