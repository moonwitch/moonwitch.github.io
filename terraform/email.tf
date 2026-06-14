# =============================================================================
# Email Routing — the kelly@ aliases.
#
#   kelly@kellyand.coffee  -> personal inbox
#   kelly@audhd.cloud      -> personal inbox
#
# Both zones run Email Routing (MX + TXT records, managed by Cloudflare). On
# audhd.cloud this happily coexists with the web redirect: mail uses MX records,
# the redirect uses the proxied A record — different record types, no conflict.
#
# The destination (your personal inbox) is already a VERIFIED account-level
# address; we don't manage that here (verifying needs a click in your inbox).
# It's read from a variable so it is NOT committed to this public repo:
#   export TF_VAR_email_forward_to="you@example.com"
#
# These already exist in Cloudflare, so IMPORT them instead of recreating
# (see ../README.md → "Adopting the existing email aliases").
# =============================================================================

locals {
  # domain => zone id, for each zone that has a kelly@ alias
  email_zones = {
    (var.canonical_domain) = data.cloudflare_zone.canonical.id
    "audhd.cloud"          = data.cloudflare_zone.redirect["audhd"].id
  }
}

resource "cloudflare_email_routing_settings" "this" {
  for_each = local.email_zones
  zone_id  = each.value
  enabled  = true
}

resource "cloudflare_email_routing_rule" "kelly" {
  for_each = local.email_zones
  zone_id  = each.value
  name     = "kelly@${each.key} -> personal inbox"
  enabled  = true

  matcher {
    type  = "literal"
    field = "to"
    value = "kelly@${each.key}"
  }

  action {
    type  = "forward"
    value = [var.email_forward_to]
  }
}
