module "resource_group" {
  source = "./resource_group"

  project           = var.project
  environment       = var.environment
  tags              = var.tags
  location          = var.location
  subscription_id   = var.subscription_id
}
module "kubernetes_cluster" {
  source = "./kubernetes_cluster"

  subscription_id = var.subscription_id
  environment     = var.environment
  location        = var.location
  project         = var.project

  vm_size = var.vm_size
  node_count = var.node_count

  public_ip = var.public_ip

  network_plugin    = var.network_plugin
  ip_versions       = var.ip_versions

  log_destination = var.log_destination.storage_account_id
  logs = var.logs
  metrics = var.metrics

  tags = var.tags
}