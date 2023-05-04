resource "aws_instance" "this" {
  ami           = "ami-0df2ca8a354185e1e"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0ea856de19a8c03c8"

  vpc_security_group_ids = [aws_security_group.this.id]

  tags = {
    Name = "terraform-sample"
  }
}

resource "aws_security_group" "this" {
  name = "terraform-sample-SG"
}
