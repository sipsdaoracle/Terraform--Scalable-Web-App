terraform {
  backend "s3" {
    bucket         = "sips-terraform-state-bucket-2"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "sips-terraform-state-lock-table-2"
  }
}
