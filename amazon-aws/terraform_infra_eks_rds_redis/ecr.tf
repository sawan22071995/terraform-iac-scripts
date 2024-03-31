# Create ECR
resource "aws_ecr_repository" "main" {
  name = var.aws_ecr_name
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = var.aws_tags
}