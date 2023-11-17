resource "aws_ecr_repository" "this" {
  name                 = "${local.resource_name_prefix}_container_repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "null_resource" "ecr_image" {
  triggers = { dir_sha1 = local.version }

  provisioner "local-exec" {
    command     = <<EOF
           aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com
           docker build -f ${var.docker_file_name} -t ${var.local_image_name} .
           docker tag ${var.local_image_name}:latest ${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${aws_ecr_repository.this.name}:${local.version}
           docker push ${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${aws_ecr_repository.this.name}:${local.version}
       EOF
    working_dir = var.local_dir_to_build
    # interpreter = ["pwsh", "-Command"] # only needed for Windows
  }

  depends_on = [aws_ecr_repository.this]
}