resource "aws_ecr_repository" "this" {
  name                 = "${var.project_name}_container_repository_${var.env}"
  image_tag_mutability = "MUTABLE"

  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = <<EOF
  {
    "rules": [
      {
        "rulePriority": 1,
        "description": "Not more than 5 images",
        "selection": {
          "tagStatus": "any",
          "countType": "imageCountMoreThan",
          "countNumber": 5
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
  EOF
}

resource "null_resource" "ecr_image" {
  triggers = { dir_sha1 = local.version }

  provisioner "local-exec" {
    command     = <<EOF
           aws ecr get-login-password --region ${local.aws_region} | docker login --username AWS --password-stdin ${var.aws_account_id}.dkr.ecr.${local.aws_region}.amazonaws.com
           docker build -f ${local.docker_file_name} -t ${local.image_name} .
           docker tag ${local.image_name}:latest ${var.aws_account_id}.dkr.ecr.${local.aws_region}.amazonaws.com/${aws_ecr_repository.this.name}:${local.version}
           docker push ${var.aws_account_id}.dkr.ecr.${local.aws_region}.amazonaws.com/${aws_ecr_repository.this.name}:${local.version}
       EOF
    working_dir = var.local_dir_to_build
    interpreter = local.worker_so == "windows" ? ["pwsh", "-Command"] : ["/bin/bash", "-c"]
  }

  depends_on = [aws_ecr_repository.this]
}