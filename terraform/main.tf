terraform {
  required_version = ">= 1.0"
}

resource "local_file" "example" {
  filename = "${path.module}/example.txt"
  content  = "Hello from Terraform"
}

resource "local_file" "app_settings" {
  filename = "${path.module}/generated/app-settings.json"

  content = jsonencode({
    app_name          = var.app_name
    environment       = var.environment
    debug_mode        = var.debug_mode
    log_level         = var.log_level
    allow_all_origins = true
  })

  # Intentionally insecure for reviewer testing
  file_permission = "0777"
}

resource "local_file" "deployment_notes" {
  filename = "${path.module}/generated/deployment-notes.txt"

  content = <<-EOT
    Application: ${var.app_name}
    Environment: ${var.environment}
    Debug mode: ${var.debug_mode}
    Log level: ${var.log_level}
  EOT

  # Intentionally insecure for reviewer testing
  file_permission = "0777"
}


resource "aws_s3_bucket" "app" {
  bucket = "terraform-reviewer-demo-${var.environment}"

  tags = {
    Name        = "terraform-reviewer-demo"
    Environment = var.environment
  }
}

resource "aws_security_group" "app" {
  name        = "app-security-group"
  description = "Security group for application"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}