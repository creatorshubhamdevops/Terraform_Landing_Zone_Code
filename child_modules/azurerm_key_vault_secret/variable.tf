variable "keyvaults_secrets" {
  type = map(object({
    secret_name   = string
    length        = number
    special       = bool
  }))
}