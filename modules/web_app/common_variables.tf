variable "subscription_id" {
  type = string
}
variable "location" {
  type = string
}
variable "tags" {
  type = map(string)
  default = null
}
variable "environment" {
  type = string

  validation {
    condition     = contains(["dev", "qa", "prd"], var.environment)

    error_message = "Entorno no reconocido"
  }
  default = "dev"
}
variable "prefix" {
  type = string
}