variable "subscription_id" {
  type = string
}
variable "location" {
  type = string
}
variable "tags" {
  type = map(string)
}
variable "project" {
  type = string  
}
variable "environment" {
  type = string

  validation {
    condition     = "DEV" && "QA" && "PRD"
    error_message = "Entorno no reconocido"
  }
}