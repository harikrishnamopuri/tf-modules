# credstash/main.tf

variable "account_id" {
  type = string
}

variable "name" {
  type = string
}

variable "read_capacity" {
  type    = string
  default = 1
}

variable "region" {
  type = string
}

variable "profile" {
  type = string
}

variable "arn_prefix" {
  type    = string
  default = "aws"
}

variable "enable_key_rotation" {
  type    = string
  default = "false"
}

# We want to create the KMS key in the specified region

provider "aws" {
  alias   = "this"
  profile = var.profile
  region  = var.region
}

resource "aws_kms_key" "credstash" {
  description         = "key for credstash-${var.name}"
  provider            = aws.this
  enable_key_rotation = var.enable_key_rotation
}

resource "aws_kms_alias" "credstash" {
  name     = "alias/credstash-${var.name}"
  provider = aws.this

  target_key_id = aws_kms_key.credstash.key_id
}

# medium.com/@leeprovoost/using-terraform-to-create-a-credstash-table-and-permissions-912b9a5a4084
resource "aws_dynamodb_table" "credstash" {
  name     = "credstash-${var.name}"
  provider = aws.this

  hash_key       = "name"
  range_key      = "version"
  read_capacity  = var.read_capacity
  write_capacity = 1

  attribute {
    name = "name"
    type = "S"
  }

  attribute {
    name = "version"
    type = "S"
  }
}

resource "aws_iam_policy" "credstash_reader" {
  name     = "iamp-kms-reader-credstash-${var.name}"
  provider = aws.this

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
  {
    "Action": [
      "kms:Decrypt"
    ],
    "Effect": "Allow",
    "Resource":
      "arn:${var.arn_prefix}:kms:${var.region}:${var.account_id}:key/${aws_kms_key.credstash.key_id}"
  },
  {
    "Action": [
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan"
    ],
    "Effect": "Allow",
    "Resource": "${aws_dynamodb_table.credstash.arn}"
  }]
}
EOF

}

resource "aws_iam_policy" "credstash_writer" {
  name     = "iamp-kms-writer-credstash-${var.name}"
  provider = aws.this

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
  {
    "Action": [
      "kms:GenerateDataKey"
    ],
    "Effect": "Allow",
    "Resource":
      "arn:${var.arn_prefix}:kms:${var.region}:${var.account_id}:key/${aws_kms_key.credstash.key_id}"
  },
  {
    "Action": [
      "dynamodb:PutItem"
    ],
    "Effect": "Allow",
    "Resource": "${aws_dynamodb_table.credstash.arn}"
  }]
}
EOF

}

# Outputs

output "table_name" {
  value = aws_dynamodb_table.credstash.name
}

output "table_arn" {
  value = aws_dynamodb_table.credstash.arn
}

output "iam_policy_credstash_reader_arn" {
  value = aws_iam_policy.credstash_reader.arn
}

output "iam_policy_credstash_writer_arn" {
  value = aws_iam_policy.credstash_writer.arn
}

output "key_arn" {
  value = aws_kms_key.credstash.arn
}

output "key_id" {
  value = aws_kms_key.credstash.key_id
}

# end

