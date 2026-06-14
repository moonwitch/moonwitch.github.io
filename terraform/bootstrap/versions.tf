terraform {
  required_version = ">= 1.5"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.40"
    }
  }
}

provider "cloudflare" {
  # A short-lived BOOTSTRAP token (not the scoped one this creates). It needs:
  #   - User  : API Tokens : Edit   (to create the token)
  #   - Zone  : Zone       : Read   (to resolve zone IDs)
  # Set via:  export TF_VAR_bootstrap_api_token=...
  api_token = var.bootstrap_api_token
}
