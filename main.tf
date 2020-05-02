provider "aws" {
  region = "us-west-2"
  access_key = "ASIA2ZZ2QG5DI5BB6XWF"
  secret_key = "XgUOpfVtzlifNoxZf9pd+/5VH1Ely4WPZRcMNrYV"
  token = "FwoGZXIvYXdzEPj//////////wEaDD9fCRoj/tE+xbAjKCLDAf1l2hyexX/6p8W0u/o4a4kacJ7uywK6mIuniJVQjzkxCqsb4iHvAmiFOF8AHwRDe4IoFzf8+o/6HZ9kUjDI+3oP1Radpo8m4NjyTZj9vp8q0cS1Lr+D9FqdlMxMhq9iVQWZnxIpqunN1ksicIxV7MLkVpcCQvA5HbN8qAApdrB9lZ7S7Aq2bfzPPiNEB3lHoV/NXIflHNQM3a1bHSYIaI3NhDKgjGShlAUpFREc++r71RzqnM58vWRou/xqBv3D2TB4aSiTnK31BTItisbztoYlqMvzFizx8Q5dxt5DRgJ3/9OxKZO8DcONRYDwPlL2ja+0QXyUNPjK"
}

module "vpc-call" {
  source = "./vpc"
}

module "rt-call" {
  source = "./routetables"
}

module "elb-call" {
  source = "./elb"
}

module "s3-fiap" {
  source = "./s3"
}
