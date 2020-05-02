variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-west-2"
}

variable "aws_amis" {
  type = map(string)
  default = {
    /*us-east-1 = "ami-13be557e"*/
    us-west-2 = "ami-06b94666"
    /*eu-west-1 = "ami-844e0bf7"*/
  }
}

variable "KEY_NAME" {
  default = "nginx-lab"
}
variable "PATH_TO_KEY" {
  default = "/home/vitorcardoso/.ssh/nginx-lab.pem"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

variable "elb_depends_on" {
  type    = any
  default = null
}
