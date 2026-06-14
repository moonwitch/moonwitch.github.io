# =============================================================================
# Email Routing — the kelly@<canonical_domain> alias.
#
# The destination (your personal inbox) is already a VERIFIED Email Routing
# address at the account level. We don't manage that here: verifying a
# destination needs a click in your inbox, which Terraform can't do. We only
# manage the forwarding rule + the zone's Email Routing on/off.
#
# The destination address is read from a variable so your personal inbox is
# NOT committed to this (public) repo — set it in terraform.tfvars or via
#   export TF_VAR_email_forward_to="you@example.com"
#
# This already exists in Cloudflare, so IMPORT it instead of recreating
# (see ../README.md → "Adopting the existing email alias").
# =============================================================================

resource "cloudflare_email_routing_settings" "this" {
  zone_id = data.cloudflare_zone.canonical.id
  enabled = true
}

resource "cloudflare_email_routing_rule" "kelly" {
  zone_id = data.cloudflare_zone.canonical.id
  name    = "kelly@ -> personal inbox"
  enabled = true

  matcher {
    type  = "literal"
    field = "to"
    value = "kelly@${var.canonical_domain}"
  }

  action {
    type  = "forward"
    value = [var.email_forward_to]
  }
}
