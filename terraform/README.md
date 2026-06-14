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

## Usage (run locally)

State lives in a local `terraform.tfstate` (gitignored). Nothing else to set up.

```sh
cd terraform
export TF_VAR_cloudflare_api_token="your-scoped-token"   # the CF_API value
export TF_VAR_account_id="your-account-id"               # the CF_ACCOUNT value (optional today)
export TF_VAR_email_forward_to="you@example.com"         # destination for the kelly@ alias
terraform init
terraform plan      # review
terraform apply
```

### Email aliases

`email.tf` manages the `kelly@kellyand.coffee` and `kelly@audhd.cloud` forwarding
rules (both → your inbox). `terraform apply` creates them — no import needed.
Email Routing must already be **enabled** on both zones (managed in the
dashboard); we manage only the rules, and the verified destination address is
left as-is.

### The API token

Create the scoped token in the Cloudflare dashboard (Zone Read + DNS Write +
Dynamic Redirect Write on the three zones), or mint it with the small standalone
Terraform config kept **outside** this repo.

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
- `allow_overwrite = true` lets Terraform **adopt** the DNS records you already
  created by hand (apex A/AAAA, `www`) instead of erroring that they exist.
- The redirect rulesets need the token's **Zone → Dynamic Redirect → Edit**
  permission. Without it Cloudflare returns `Authentication error (10000)`.
- Provider is pinned to the **v4** line and uses `content`. On provider **v5**,
  rename `cloudflare_record` → `cloudflare_dns_record`.
- **Email Routing** (the `kelly@kellyand.coffee` alias) lives on `MX` + `TXT`/DKIM
  records that are **not** managed here. Terraform only touches the records it
  declares (apex `A`/`AAAA`, `www`), so the email forwarding is left untouched —
  manage it in the Cloudflare dashboard and keep Email permissions off the token.
