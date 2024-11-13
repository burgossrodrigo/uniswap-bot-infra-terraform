resource "aws_instance" "sniper-bot" {
  ami           = "ami-02f3f602d23f1659d"
  instance_type = "t3.micro"
  tags = {
    ambiente = "prod"
    Name     = var.instance_name
  }

  root_block_device {
    volume_size = 10
  }

  user_data = file("user_data.sh")
}