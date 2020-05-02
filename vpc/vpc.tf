provider "aws" {
  region = "us-west-2"
  access_key = "ASIA2ZZ2QG5DI5BB6XWF"
  secret_key = "XgUOpfVtzlifNoxZf9pd+/5VH1Ely4WPZRcMNrYV"
  token = "FwoGZXIvYXdzEPj//////////wEaDD9fCRoj/tE+xbAjKCLDAf1l2hyexX/6p8W0u/o4a4kacJ7uywK6mIuniJVQjzkxCqsb4iHvAmiFOF8AHwRDe4IoFzf8+o/6HZ9kUjDI+3oP1Radpo8m4NjyTZj9vp8q0cS1Lr+D9FqdlMxMhq9iVQWZnxIpqunN1ksicIxV7MLkVpcCQvA5HbN8qAApdrB9lZ7S7Aq2bfzPPiNEB3lHoV/NXIflHNQM3a1bHSYIaI3NhDKgjGShlAUpFREc++r71RzqnM58vWRou/xqBv3D2TB4aSiTnK31BTItisbztoYlqMvzFizx8Q5dxt5DRgJ3/9OxKZO8DcONRYDwPlL2ja+0QXyUNPjK"
}

resource "aws_vpc" "vpc_created" {
  cidr_block = var.vpc_cidr
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = var.project
    env = var.env
  }
}

resource "aws_subnet" "public_igw" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.vpc_created.id
  cidr_block = cidrsubnet(var.vpc_cidr, var.subnet_escale, count.index+1)
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.project}_public_igw_${data.aws_availability_zones.available.names[count.index]}"
    Tier = "Public"
    env = var.env
  }
}
