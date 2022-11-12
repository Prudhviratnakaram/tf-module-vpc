resource  "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    name = "${var.env}-vpc"
  }
}
module "subnets" {
  for_each = var.subnets
  source   = "./subnets"
  name     = each.value["name"]
  subnets  = each.value["subnet_cidr"]
  vpc_id   = aws_vpc.main.id
  ngw = try(each.value["ngw"],false)
  igw = try(each.value["ngw"],false)
  env = var.env
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-igw"
  }
}