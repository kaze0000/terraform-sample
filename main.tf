resource "aws_instance" "this" {
  ami           = "ami-0df2ca8a354185e1e"
  instance_type = "t2.micro"
  subnet_id = "subnet-0ea856de19a8c03c8"

  tags = {
    Name = "terraform-sample"
  }
}
