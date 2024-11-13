output "public_ip" {
    value = aws_instance.sniper-bot.public_ip
    description = "The public IP address of the web server"
}

output "instance_id" {
    value = aws_instance.sniper-bot.id
    description = "The ID of the web server instance"
}