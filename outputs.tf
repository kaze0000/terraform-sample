# terraform apply時にアクセス先のURLを出力させる
output "url" {
  value = "http://${aws_instance.this.public_ip}"
}
