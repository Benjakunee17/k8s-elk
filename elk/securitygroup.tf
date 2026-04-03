/**
 * Create by : Benja kuneepong
 * Date : Thu Feb 26 08:40:43 +07 2026
 * Purpose : ใช้สำหรับอนุญาติให้ traffic ทั้งหมดเข้า EC2 linux ได้
 */
resource "aws_security_group" "ec2_ssh_sg" {
  name        = "ec2-linux-sg-securitygroup"
  description = "Allow ssh traffic to EC2 instances"
  vpc_id      = var.vpc_id



  ingress {
    description      = "Allow ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }

 ingress {
    description      = "Allow all"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = []
    self             = true
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "ec2-ssh-securitygroup"
  }
}

/**
 * Create by : Benja kuneepong
 * Date : Wed, Aug  7, 2024  1:59:35 PM
 * Purpose : ใช้สำหรับอนุญาติให้ traffic ทั้งหมดเข้า EC2 ด้วย protocol web ได้
 */
resource "aws_security_group" "ec2_web_sg" {
  name        = "ec2-web-sg-securitygroup"
  description = "Allow web traffic to EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow all"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

#ใช้สำหรับ jenkin , tomcat
   ingress {
    description      = "Allow all"
    from_port        = 8080
    to_port          = 9200
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
#ใช้สำหรับ https
 
  ingress {
    description      = "Allow all"
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow all"
    from_port        = 5601
    to_port          = 5601
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "ec2-web-securitygroup"
  }
}

