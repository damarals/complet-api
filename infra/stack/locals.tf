locals {
  version = sha1(join("", [for f in fileset("${var.local_dir_to_build}", "**") : filesha1("${var.local_dir_to_build}/${f}")]))
  resource_name_prefix  = "${var.aws_function_name}_${var.stage}"
}