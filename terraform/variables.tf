variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "demo-api"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}

variable "debug_mode" {
  description = "Enable verbose debugging"
  type        = bool
  default     = true
}

variable "log_level" {
  description = "Application log level"
  type        = string
  default     = "DEBUG"
}
