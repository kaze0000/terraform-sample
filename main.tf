resource "aws_instance" "this" {
  ami           = "ami-0df2ca8a354185e1e"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0ea856de19a8c03c8"

  vpc_security_group_ids = [aws_security_group.this.id]

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install -y nginx1
              sudo yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF
  user_data_replace_on_change = true

  tags = {
    Name = "terraform-sample"
  }
}

resource "aws_security_group" "this" {
  name = "terraform-sample-SG"
}

# インバウンドルール、アウトバウンドルールの設定
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}

# nginxをインストールする予定なので以下を追加して、外に出る通信を許可する
resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}
