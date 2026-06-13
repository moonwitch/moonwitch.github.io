terraform {
  required_version = ">= 1.5"

  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      # v4 line. Uses `content` (not the deprecated `value`). On provider v5,
      # rename cloudflare_record -> cloudflare_dns_record.
      version = "~> 4.40"
    }
  }
}

provider "cloudflare" {
  # Set via env var:  export TF_VAR_cloudflare_api_token=...
  api_token = var.cloudflare_api_token
}
