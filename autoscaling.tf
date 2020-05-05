# Create an autoscaling group for the NGINX Plus load balancer instances
resource "aws_autoscaling_group" "chavo-nginx" {
  name                 = "ngx-autoscaling"
  min_size             = 2
  max_size             = 10
  launch_configuration = aws_launch_configuration.chavo-nginx.name
  vpc_zone_identifier = [
    aws_subnet.private.id,
  ]
  tags = [
    {
      key                 = "Name"
      value               = "chavo-nginx"
      propagate_at_launch = true
    },
    {
      key                 = "Timestamp"
      value               = timestamp()
      propagate_at_launch = true
    },
  ]
  target_group_arns = [
    aws_lb_target_group.http.arn,
    aws_lb_target_group.https.arn,
    aws_lb_target_group.ssh.arn,
  ]
}
