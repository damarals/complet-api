locals {
  version = sha1(join("", [for f in fileset("${var.local_dir_to_build}", "**") : filesha1("${var.local_dir_to_build}/${f}")]))
  prefix = "${var.api_name}_${var.api_stage}"
}