locals {
    workspace_name = join(var.common_delimiter, [var.common_name, terraform.workspace])
}