#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y nginx1
sudo yum install -y nginx
systemctl start nginx
systemctl enable nginx
