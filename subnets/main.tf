resource "aws_subnet" "main" {
  count             = length(var.subnets)
  vpc_id            = var.vpc_id
  cidr_block        = var.subnets[count.index]
  availability_zone = var.AZ[count.index]

  tags = {
    Name = "${var.name}-subnet"
  }
}