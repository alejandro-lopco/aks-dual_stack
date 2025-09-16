variable "arc_kubernetes_cluster_name" {
  type = string

  description = "Nombre del cluster de Kubernetes de Azure Arc"
}

variable "agent_public_key_certificate" {
  type = string

  description = "Ruta al fichero con el certificado de clave pública para el Agente de Azure Arc"
}
