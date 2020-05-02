# Specify the provider and access details
provider "aws" {
  region = "us-west-2"
  access_key = "ASIA2ZZ2QG5DI5BB6XWF"
  secret_key = "XgUOpfVtzlifNoxZf9pd+/5VH1Ely4WPZRcMNrYV"
  token = "FwoGZXIvYXdzEPj//////////wEaDD9fCRoj/tE+xbAjKCLDAf1l2hyexX/6p8W0u/o4a4kacJ7uywK6mIuniJVQjzkxCqsb4iHvAmiFOF8AHwRDe4IoFzf8+o/6HZ9kUjDI+3oP1Radpo8m4NjyTZj9vp8q0cS1Lr+D9FqdlMxMhq9iVQWZnxIpqunN1ksicIxV7MLkVpcCQvA5HbN8qAApdrB9lZ7S7Aq2bfzPPiNEB3lHoV/NXIflHNQM3a1bHSYIaI3NhDKgjGShlAUpFREc++r71RzqnM58vWRou/xqBv3D2TB4aSiTnK31BTItisbztoYlqMvzFizx8Q5dxt5DRgJ3/9OxKZO8DcONRYDwPlL2ja+0QXyUNPjK"
}

variable "project" {
  default = "fiap-lab"
}

data "aws_vpc" "vpc" {
  tags = {
    Name = "fiap-lab"
  }
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags = {
    Tier = "Public"
  }
}

data "aws_subnet" "public" {
  for_each = data.aws_subnet_ids.all.ids
  id = each.value
}

resource "random_shuffle" "random_subnet" {
  input        = [for s in data.aws_subnet.public : s.id]
  result_count = 1
}

resource "aws_elb" "web" {
  name = "terraform-elb-${terraform.workspace}"

  subnets         = data.aws_subnet_ids.all.ids
  security_groups = [aws_security_group.allow-ssh.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 6
  }

  # The instances are registered automatically
  instances = aws_instance.web.*.id
}

resource "aws_instance" "web" {
  instance_type = "t2.micro"
  ami           = lookup(var.aws_amis, var.aws_region)

  count = 2

  subnet_id              = random_shuffle.random_subnet.result[0]
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  key_name               = var.KEY_NAME

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }

  connection {
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_KEY)
    host = self.public_dns
  }

  tags = {
    Name = format("nginx-${terraform.workspace}-%03d", count.index + 1)
  }
}
