# bootstrap — mint the scoped DNS token (run once)

Optional. Creates the least-privilege Cloudflare token that the main config
(`../`) authenticates with, so the token itself is defined as code.

It lives in its own directory (own state) **on purpose**: the scoped token it
produces only has DNS/redirect permissions and cannot read API tokens, so it
must not be in a config that would try to refresh/manage a token resource.

## Run it (once)

```sh
cd terraform/bootstrap
export TF_VAR_bootstrap_api_token="<admin token>"   # User:API Tokens:Edit + Zone:Read
terraform init
terraform apply
terraform output -raw token_value
```

Take that value and:
- paste it into the GitHub **`CF_API`** secret, and/or
- put it in `../terraform.tfvars` as `cloudflare_api_token = "..."`.

## Notes

- The created token grants only **Zone Read + DNS Write + Dynamic Redirect
  Write** on the three zones — exactly what `../main.tf` and `../email.tf` need.
- The token **value is stored in this directory's state** (sensitive). Keep the
  state private (the `.gitignore` here excludes it). For a shared/remote setup,
  use an encrypted backend.
- Prefer not to manage the token as code? Skip this entirely and create the
  token in the Cloudflare dashboard with the same three permissions.
- Couldn't be `terraform validate`d in CI here (provider registry blocked in the
  sandbox); permission-group attribute/name can vary slightly by provider
  version — see the note in `main.tf` if a lookup errors.
