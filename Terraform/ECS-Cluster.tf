# Define ECS Cluster
resource "aws_ecs_cluster" "my_cluster" {
  name = "my-ecs-cluster"
}

# IAM role for ECS instances
resource "aws_iam_role" "ecs_instance_role" {
  name = "ecs-instance-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })
}

# Attach IAM policy to ECS instance role
resource "aws_iam_role_policy_attachment" "ecs_instance_role_policy_attachment" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# Define ECS Launch Configuration
resource "aws_launch_configuration" "ecs_launch_config" {
  name          = "ecs-launch-config"
  image_id      = data.aws_ecs_container_instance.ami.id
  instance_type = "t2.micro"  # Adjust as needed
  iam_instance_profile = aws_iam_role.ecs_instance_role.name

  lifecycle {
    create_before_destroy = true
  }
}

# Define Auto Scaling Group for ECS instances
resource "aws_autoscaling_group" "ecs_autoscaling_group" {
  name                 = "ecs-autoscaling-group"
  launch_configuration = aws_launch_configuration.ecs_launch_config.name
  min_size             = 1
  max_size             = 3   # Adjust as needed
  desired_capacity     = 2   # Adjust as needed

  tag {
    key                 = "Name"
    value               = "ecs-instance"
    propagate_at_launch = true
  }

  # Add subnet IDs here
  vpc_zone_identifier = [
    "subnet-xxxxxxxx",
    "subnet-yyyyyyyy"
  ]
}
