output "canonical_zone_id" {
  value       = data.cloudflare_zone.canonical.id
  description = "Zone ID of the canonical site domain."
}

output "redirects_configured" {
  value = {
    for k, v in var.redirects :
    v.zone_name => "301 -> https://${var.canonical_domain}${v.dest_path}"
  }
  description = "Summary of the redirects this config manages."
}
