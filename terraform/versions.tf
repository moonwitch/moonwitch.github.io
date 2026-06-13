terraform {
  required_version = ">= 1.5"

  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      # Pinned to the v4 line. If you adopt provider v5, rename
      # cloudflare_record -> cloudflare_dns_record and its `value` -> `content`.
      version = "~> 4.40"
    }
  }
}

provider "cloudflare" {
  # Set via env var:  export TF_VAR_cloudflare_api_token=...
  api_token = var.cloudflare_api_token
}
