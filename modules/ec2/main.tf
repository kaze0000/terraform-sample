resource "aws_instance" "this" {
  ami           = "ami-0df2ca8a354185e1e"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [aws_security_group.this.id]

  associate_public_ip_address = true

  user_data = file("${path.module}/user_data.sh")
  user_data_replace_on_change = true

  tags = {
    Name = "terraform-sample"
  }
}

data "aws_subnet" "this" {
  id = var.subnet_id //データソースで検索するサブネットのIDを指定
}

resource "aws_security_group" "this" {
  # subnet_idからvpc_idを取得する(data resourceを使う)
  vpc_id = data.aws_subnet.this.vpc_id
  name = "terraform-sample-SG"
}

# インバウンドルール、アウトバウンドルールの設定
resource "aws_security_group_rule" "ssh" {
  # count = 2 # 2つのルールを設定する
  count = var.allow_ssh ? 1 : 0

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
