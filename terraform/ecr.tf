resource "aws_ecr_repository" "nextcloud_app" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.ecr_repository_name}-repo"
    }
  )
}

resource "aws_ecr_lifecycle_policy" "nextcloud_app_policy" {
  repository = aws_ecr_repository.nextcloud_app.name

  policy = jsonencode({
    rules = [
      # 1. Expire untagged images older than 30 days
      {
        rulePriority = 1,
        description  = "Expire untagged images >30 days",
        selection = {
          tagStatus   = "untagged",
          countType   = "sinceImagePushed",
          countUnit   = "days",
          countNumber = 30
        },
        action = {
          type = "expire"
        }
      },
      # 2. Keep last 10 images for common tag patterns
      {
        rulePriority = 2,
        description  = "Keep last 10 tagged images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v", "latest", "main", "dev", "prod", "release"],
          countType     = "imageCountMoreThan",
          countNumber   = 10
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}