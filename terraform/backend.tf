terraform {
  backend "s3" {
    bucket = "terraform-bucket-shakti"   # <<< Replace with your S3 bucket name
    key    = "terraform/state.tfstate"
    region = "ap-south-1"
  }
}
