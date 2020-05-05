# Create launch configuration for NGINX  instances
resource "aws_launch_configuration" "chavo-nginx" {
  name          = "chavo-nginx"
  image_id      = var.nginx_ami
  instance_type = var.machine_type
  key_name      = var.key_name
  security_groups = [
    aws_security_group.private.id,
  ]
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.main.name
}
