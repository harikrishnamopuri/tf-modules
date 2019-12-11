cidr_block = "10.0.0.0/16"
instance_tenancy = "default"
name = "test-vpc"
region = "us-east-2"
zones = ["us-east-2a", "us-east-2b", "us-east-2c" ]
public_subnets  = ["10.0.255.0/24", "10.0.254.0/24", "10.0.253.0/24"]
private_subnets = ["10.0.12.0/24", "10.0.16.0/24", "10.0.20.0/24"]

