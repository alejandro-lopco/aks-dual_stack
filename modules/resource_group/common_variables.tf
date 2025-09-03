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
variable "project" {
  type = string
  default = null
}
variable "environment" {
  type = string

  validation {
    condition     = contains(["DEV", "QA", "PRD"], var.environment)
    error_message = "Entorno no reconocido"
  }
  default = "DEV"
}
variable "prefix" {
  type = string
}