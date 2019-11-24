terraform {
  backend "s3" {
    bucket = "hari-tfbucket"
    key    = "tfstore/global/"
    region = "us-east-1"
  }
}
