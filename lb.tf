resource "aws_eip" "nginx-eip" {
  vpc = true
  tags = {
    Name = "nginx-eip"
  }
}

# Create AWS NLB
resource "aws_lb" "main" {
  name               = "aws-nlb-lb"
  load_balancer_type = "network"
  subnets = [
    aws_subnet.public.id,
  ]
  tags = {
    Environment = "nginx_lb"
  }
  depends_on = [aws_internet_gateway.internet_gw]
}

# Create AWS NLB target group
resource "aws_lb_target_group" "http" {
  name     = "aws-nlb-lb-tg-http"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.nginx-vpc.id
}

# Create AWS NLB listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "TCP"
  default_action {
    target_group_arn = aws_lb_target_group.http.arn
    type             = "forward"
  }
}

# Create AWS NLB target group ssh
resource "aws_lb_target_group" "ssh" {
  name     = "aws-nlb-lb-tg-ssh"
  port     = 22
  protocol = "TCP"
  vpc_id   = aws_vpc.nginx-vpc.id
}

# Create AWS NLB listener ssh
resource "aws_lb_listener" "ssh" {
  load_balancer_arn = aws_lb.main.arn
  port              = "22"
  protocol          = "TCP"
  default_action {
    target_group_arn = aws_lb_target_group.ssh.arn
    type             = "forward"
  }
}

# Create AWS NLB target group https
resource "aws_lb_target_group" "https" {
  name     = "aws-nlb-lb-tg-https"
  port     = 443
  protocol = "TCP"
  vpc_id   = aws_vpc.nginx-vpc.id
}

# Create AWS NLB listener https
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "TCP"
  default_action {
    target_group_arn = aws_lb_target_group.https.arn
    type             = "forward"
  }
}
