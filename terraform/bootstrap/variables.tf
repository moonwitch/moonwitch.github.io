variable "bootstrap_api_token" {
  type        = string
  sensitive   = true
  description = "Short-lived admin token used ONCE to mint the scoped DNS token (User:API Tokens:Edit + Zone:Read)."
}

variable "token_name" {
  type        = string
  default     = "kellyandcoffee-dns-tf"
  description = "Name for the scoped token this creates."
}

variable "zone_names" {
  type        = list(string)
  default     = ["kellyand.coffee", "audhd.cloud", "kellyc.dev"]
  description = "Zones the scoped token may touch."
}
