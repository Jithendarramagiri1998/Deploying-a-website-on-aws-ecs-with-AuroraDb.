terraform {
  backend "s3" {
    bucket         = "ecs-aurora-terraform-state-bucket-jeetu"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
