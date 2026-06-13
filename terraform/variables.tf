variable "cloudflare_api_token" {
  type        = string
  sensitive   = true
  description = <<-EOT
    Cloudflare API token. Scope it to the three zones with:
      - Zone : Zone     : Read
      - Zone : DNS      : Edit
      - Zone : Dynamic Redirect : Edit   (for the Single Redirect rulesets)
  EOT
}

variable "canonical_domain" {
  type        = string
  default     = "kellyand.coffee"
  description = "The one site everything else points at (served by GitHub Pages)."
}

variable "github_pages_host" {
  type        = string
  default     = "moonwitch.github.io"
  description = "Your GitHub Pages host, used for the www CNAME on the canonical domain."
}

# The redirect map: source zone -> destination path on the canonical domain.
variable "redirects" {
  type = map(object({
    zone_name = string
    dest_path = string # path on the canonical domain, with leading + trailing slash
  }))
  default = {
    audhd = {
      zone_name = "audhd.cloud"
      dest_path = "/audhd/"
    }
    dev = {
      zone_name = "kellyc.dev"
      dest_path = "/dev/"
    }
  }
}
