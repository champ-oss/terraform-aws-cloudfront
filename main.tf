provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

locals {
  tags = {
    git     = var.git
    cost    = "shared"
    creator = "terraform"
  }
}