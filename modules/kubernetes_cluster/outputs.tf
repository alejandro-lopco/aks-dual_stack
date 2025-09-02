output "client_certificate" {
  value     = azurerm_kubernetes_cluster.this.kube_config[0].client_certificate

  description = "Certificado de cliente para autentcarse y gestionar el cluster"
  sensitive   = true
}
output "kube_config" {
  value     = azurerm_kubernetes_cluster.this.kube_config_raw

  description = "Contenido del archivo kubeconfig para gestionar el cluster"
  sensitive   = true
}