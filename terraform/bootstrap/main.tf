# =============================================================================
# Mints the least-privilege token that the main config (../) uses.
# Run ONCE, with an admin bootstrap token. Separate state on purpose: the
# scoped token can't read tokens, so it must never manage itself.
#
#   terraform init
#   export TF_VAR_bootstrap_api_token=<admin token>
#   terraform apply
#   terraform output -raw token_value     # -> paste into the CF_API secret / ../terraform.tfvars
# =============================================================================

# Look up permission-group IDs by name (so we don't hardcode opaque UUIDs).
data "cloudflare_api_token_permission_groups" "all" {}

data "cloudflare_zone" "z" {
  for_each = toset(var.zone_names)
  name     = each.value
}

resource "cloudflare_api_token" "dns" {
  name = var.token_name

  policy {
    effect = "allow"
    # NOTE: these are the human-readable permission-group names. If a name has
    # drifted in your provider version, run `terraform console` then inspect
    # `data.cloudflare_api_token_permission_groups.all.zone` and adjust.
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.zone["Zone Read"],
      data.cloudflare_api_token_permission_groups.all.zone["DNS Write"],
      data.cloudflare_api_token_permission_groups.all.zone["Dynamic Redirect Write"],
    ]
    # Scope to exactly the three zones (least privilege).
    resources = {
      for z in data.cloudflare_zone.z : "com.cloudflare.api.account.zone.${z.id}" => "*"
    }
  }

  # Optional hardening: uncomment to expire the token.
  # expires_on = "2027-01-01T00:00:00Z"
}

output "token_value" {
  value       = cloudflare_api_token.dns.value
  sensitive   = true
  description = "The scoped token. Read with: terraform output -raw token_value"
}
