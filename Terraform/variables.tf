variable "aws_region" {
  description = "The AWS region where resources will be provisioned."
  default     = "us-west-2"  # Change this to your desired region
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster."
  default     = "my-ecs-cluster"
}

variable "ecs_instance_type" {
  description = "The instance type for ECS instances."
  default     = "t2.micro"
}

variable "ecs_min_size" {
  description = "The minimum number of ECS instances in the Auto Scaling Group."
  default     = 1
}

variable "ecs_max_size" {
  description = "The maximum number of ECS instances in the Auto Scaling Group."
  default     = 3
}

variable "ecs_desired_capacity" {
  description = "The desired number of ECS instances in the Auto Scaling Group."
  default     = 2
}

# variable "api_app_source_dir" {
#   description = "The path to the directory containing the API application source code."
#   default     = "/path/to/your/api_app"
# }
