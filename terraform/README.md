# Cloudflare DNS & redirects (Unified Blueprint)

One site, three domains:

| Domain | Role | Result |
|---|---|---|
| `kellyand.coffee` | **Canonical site** | Served by GitHub Pages |
| `audhd.cloud` | Redirect | `301 → https://kellyand.coffee/audhd/` |
| `kellyc.dev` | Redirect | `301 → https://kellyand.coffee/dev/` |

All three domains must already be added to your Cloudflare account and using
Cloudflare's nameservers. This config manages the DNS records and the redirect
rules inside those zones — it does not register domains or move nameservers.

## Prerequisites

1. A Cloudflare **API token** scoped to the three zones with:
   - Zone → Zone → **Read**
   - Zone → DNS → **Edit**
   - Zone → Dynamic Redirect → **Edit**
2. In the GitHub repo: **Settings → Pages → Custom domain = `kellyand.coffee`**
   (the repo's `static/CNAME` already pins this on deploy).

## Usage

```sh
cd terraform
export TF_VAR_cloudflare_api_token="your-scoped-token"
terraform init
terraform plan      # review
terraform apply
```

## Order of operations (important)

GitHub Pages serves only the domain in `CNAME` (`kellyand.coffee`). To avoid an
outage:

1. `terraform apply` here so `kellyand.coffee` resolves to GitHub Pages.
2. Confirm `https://kellyand.coffee` loads and gets a valid TLS cert
   (GitHub provisions it automatically once DNS points at Pages).
3. **Then** merge the site PR so the `kellyand.coffee` `CNAME` deploys.
4. Verify the redirects: `curl -sI https://audhd.cloud` should show
   `301` → `https://kellyand.coffee/audhd/`.

## Notes

- The canonical apex records are **DNS-only (grey cloud)** so GitHub Pages can
  issue its own TLS certificate. The redirect domains are **proxied (orange
  cloud)** because Cloudflare must terminate the request to run the redirect.
- The `192.0.2.1` placeholder on the redirect domains is an RFC 5737
  documentation address; it is never actually contacted because the redirect
  fires at Cloudflare's edge first.
- Provider is pinned to the **v4** line. On provider **v5**, rename
  `cloudflare_record` → `cloudflare_dns_record` and its `value` → `content`.
