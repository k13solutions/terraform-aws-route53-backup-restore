resource "null_resource" "deploy_route53_backup_and_restore" {
  triggers = {
    build = timestamp()
    interval = var.interval
    retention_period = var.retention_period
    region = var.region
    aws_profile = var.aws_profile
    service_name = var.service_name
  }

  provisioner "local-exec" {
    working_dir = path.module
    command     = "npm i && sls deploy --config config.yml --region '${self.triggers.region}' --aws-profile '${self.triggers.aws_profile}'"
  }

resource "null_resource" "remove_route53_backup_and_restore" {
  provisioner "local-exec" {
    when        = destroy
    working_dir = path.module
    command     = "npm i && sls remove --config config.yml --region '${self.triggers.region}' --aws-profile '${self.triggers.aws_profile}'"
  }
}
