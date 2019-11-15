terraform {
  required_version = ">= 0.12"
}

resource "random_id" "name" {
  byte_length = 6
  prefix      = "tf-vault-"
}

module "vault-py3" {
  source = "../../"

  environment      = var.environment
  desired_capacity = 1
  ami_owners       = var.ami_owners

  name           = "${random_id.name.hex}-py3"
  key_pair_name  = var.key_pair_name
  kms_key_id     = null
  ec2_subnet_ids = var.ec2_subnet_ids
  lb_subnet_ids  = var.lb_subnet_ids

  cloudwatch_agent_url         = var.cloudwatch_agent_url
  ec2_extra_security_group_ids = var.ec2_extra_security_group_ids

  scale_up_schedule   = var.scale_up_schedule
  scale_down_schedule = var.scale_down_schedule

  domain_name     = var.domain_name
  route53_zone_id = var.route53_zone_id
  certificate_arn = var.certificate_arn

  # Vault settings
  vault_version        = var.vault_version
  vault_pillar_path    = var.vault_pillar_path
  dynamodb_table       = var.dynamodb_table
  pillar_template_vars = var.pillar_template_vars

  # Watchmaker settings
  watchmaker_config = var.watchmaker_config

  toggle_update = var.toggle_update
}

output "cluster_url" {
  value = module.vault-py3.vault_url
}
