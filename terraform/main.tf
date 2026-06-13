# =============================================================================
# Unified Blueprint — one site on kellyand.coffee, the other two domains
# 301-redirect into deep sections of it.
#
#   kellyand.coffee   -> GitHub Pages (the actual site)
#   audhd.cloud       -> 301 -> https://kellyand.coffee/audhd/
#   kellyc.dev        -> 301 -> https://kellyand.coffee/dev/
#
# The zones must already exist in your Cloudflare account (i.e. the domains
# are added to Cloudflare and using its nameservers). This only manages the
# records and redirect rules inside them.
# =============================================================================

locals {
  # GitHub Pages anycast addresses (apex). See:
  # https://docs.github.com/pages/configuring-a-custom-domain-for-your-github-pages-site
  gh_pages_ipv4 = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153",
  ]
  gh_pages_ipv6 = [
    "2606:50c0:8000::153",
    "2606:50c0:8001::153",
    "2606:50c0:8002::153",
    "2606:50c0:8003::153",
  ]
}

# ---- Look up the zones by name --------------------------------------------
data "cloudflare_zone" "canonical" {
  name = var.canonical_domain
}

data "cloudflare_zone" "redirect" {
  for_each = var.redirects
  name     = each.value.zone_name
}

# =============================================================================
# Canonical domain: kellyand.coffee -> GitHub Pages
# DNS-only (grey cloud) so GitHub Pages can issue and renew its TLS cert.
# =============================================================================
resource "cloudflare_record" "apex_a" {
  for_each = toset(local.gh_pages_ipv4)
  zone_id  = data.cloudflare_zone.canonical.id
  name     = "@"
  type     = "A"
  value    = each.value
  proxied  = false
  ttl      = 1
  comment  = "GitHub Pages apex"
}

resource "cloudflare_record" "apex_aaaa" {
  for_each = toset(local.gh_pages_ipv6)
  zone_id  = data.cloudflare_zone.canonical.id
  name     = "@"
  type     = "AAAA"
  value    = each.value
  proxied  = false
  ttl      = 1
  comment  = "GitHub Pages apex (IPv6)"
}

resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zone.canonical.id
  name    = "www"
  type    = "CNAME"
  value   = var.github_pages_host
  proxied = false
  ttl     = 1
  comment = "www -> GitHub Pages"
}

# =============================================================================
# Redirect domains: audhd.cloud, kellyc.dev
# A proxied placeholder record gives Cloudflare a hostname to intercept; the
# request never reaches the placeholder IP because the redirect fires first.
# =============================================================================
resource "cloudflare_record" "redirect_apex" {
  for_each = var.redirects
  zone_id  = data.cloudflare_zone.redirect[each.key].id
  name     = "@"
  type     = "A"
  value    = "192.0.2.1" # RFC 5737 TEST-NET-1 placeholder; never contacted
  proxied  = true        # MUST be proxied (orange cloud) for the redirect to run
  ttl      = 1
  comment  = "Placeholder for redirect to ${var.canonical_domain}${each.value.dest_path}"
}

resource "cloudflare_record" "redirect_www" {
  for_each = var.redirects
  zone_id  = data.cloudflare_zone.redirect[each.key].id
  name     = "www"
  type     = "CNAME"
  value    = each.value.zone_name
  proxied  = true
  ttl      = 1
  comment  = "www -> redirect"
}

# Single Redirect (dynamic redirect ruleset): 301 the whole apex + www to the
# matching deep section on the canonical domain, preserving the query string.
resource "cloudflare_ruleset" "redirect" {
  for_each = var.redirects
  zone_id  = data.cloudflare_zone.redirect[each.key].id
  name     = "${each.value.zone_name} -> ${var.canonical_domain}${each.value.dest_path}"
  kind     = "zone"
  phase    = "http_request_dynamic_redirect"

  rules {
    ref         = "redirect_${each.key}"
    description = "301 ${each.value.zone_name} to the canonical section"
    expression  = format("(http.host eq \"%s\" or http.host eq \"www.%s\")", each.value.zone_name, each.value.zone_name)
    action      = "redirect"

    action_parameters {
      from_value {
        status_code           = 301
        preserve_query_string = true
        target_url {
          value = "https://${var.canonical_domain}${each.value.dest_path}"
        }
      }
    }
  }
}
