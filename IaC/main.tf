terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  profile = "default"
  region = "eu-central-1"
}

resource "aws_lambda_function" "cv_cloud_lambda" {
  function_name    = "cv_cloud_api"
  handler          = "func.lambda_handler"
  runtime          = "python3.10"
  filename         = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")

  role = "arn:aws:iam::592311206889:role/service-role/cv_cloud_api-role-byznl53o"
}

resource "aws_dynamodb_table" "cv_cloud_table" {
  name           = "cv_cloud_shabnam"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id_nr"

  attribute {
    name = "id_nr"
    type = "S"
  }

}


resource "aws_api_gateway_rest_api" "cv_cloud_api" {
  name        = "cv_cloud_api_gateway"
  description = "API Gateway for Lambda function"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}


