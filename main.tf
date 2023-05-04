resource "aws_instance" "this" {
  ami           = "ami-0df2ca8a354185e1e"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-sample"
  }
}
