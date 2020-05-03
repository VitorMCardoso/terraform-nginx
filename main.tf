provider "aws" {
  region = "us-west-2"
}

module "rt-call" {
  source = "./routetables"
}

module "elb-call" {
  source = "./elb"
  quantidade = 1
}

module "s3-fiap" {
  source = "./s3"
}
