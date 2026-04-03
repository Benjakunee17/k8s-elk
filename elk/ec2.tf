# /**
#  * Create by : Benja kuneepong
#  * Date : Wed Feb 25 15:51:01 +07 2026
#  * Purpose : สร้าง key pair สำหรับ EC2
#  */
resource "aws_key_pair" "ec2-instance" {
  key_name   = "ec2-instance"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBJJDTRl1d+LSft0Jz+w9LatuZMEYPeV+0LECyn4gK2x benjakuneepong@Benjas-MacBook-Air.local"





}
/**
 * Create by : Benja kuneepong
 * Date : Wed Feb 25 15:51:01 +07 2026
 * Purpose : สร้าง EC2 
 */
resource "aws_instance" "ec2-instance" {
  ami                         = var.ec2_instance_image
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = true

  key_name               = aws_key_pair.ec2-instance.key_name
  subnet_id              = var.subnet_b
  vpc_security_group_ids = [aws_security_group.ec2_ssh_sg.id,aws_security_group.ec2_web_sg.id]
  user_data = file("user-data.sh")

  root_block_device {
    volume_size           = "50"
    volume_type           = "gp3"
   
  }

  
  tags = {
    Name        = "ec2-elk"
    "Automatic stop/start schedule" = "Enabled"
  }
  

  volume_tags = {
    Name        = "ec2-elk-volume"
    Createby    = var.create_by_name
  

  }

  # Keep this ami always
  lifecycle {
    ignore_changes = [ami,volume_tags,user_data]
  }

 }
