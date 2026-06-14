# Kelly and Coffee

Source for [kellyand.coffee](https://kellyand.coffee) — the personal site and blog of
Kelly Crabbé: a neurodivergent, queer DevOps & automation engineer who writes about
tech, accessibility, and showing up as her whole self.

Two front doors share one site:

- **Tech** (`/dev/`) — DevOps, cloud, and low-code automation.
- **Advocacy** (`/audhd/`) — being AuDHD and queer in tech, accessibility, public speaking.

## Stack

- **[Hugo](https://gohugo.io) extended `0.163.1`** — static site generator (pinned in CI; keep your local version in sync).
- **Dart Sass** — SCSS in `assets/scss/` is transpiled and fingerprinted through Hugo Pipes.
- **Custom theme** — there is no external theme; all templates live in `layouts/`.
- **Vanilla JS** (`assets/js/app.js`) + GSAP/ScrollTrigger (scroll reveals) and three.js (home hero only), fingerprinted with Subresource Integrity.
- **[giscus](https://giscus.app)** — GitHub Discussions–backed comments.
- **[Sveltia CMS](https://github.com/sveltia/sveltia-cms)** — optional web editor at `/admin/`.
- **GitHub Pages** — built and deployed by GitHub Actions on every push to `main`.

### Look & feel

Themed with CSS custom properties via `[data-theme]` (dark default, light toggle), tokens in `assets/scss/main.scss`:

| Token | Dark | Light |
| --- | --- | --- |
| Background | `#0e0c1d` | `#fbf7ef` |
| Text | `#f3f0fb` | `#1c1633` |
| Accent (gold) | `#ffd166` | `#b8860b` |
| Link | `#c8b3ff` | `#6b34d6` |
| Coffee | `#d8a47f` | `#8a4b2f` |

Pride-gradient accents run through the hero and brand mark. Fonts: **Atkinson Hyperlegible**
(body — chosen for readability), **Fraunces** (display headings), **Source Code Pro** (mono).

## Local development

Requires Hugo **extended** `0.163.1` and Dart Sass on your `PATH`.

```sh
brew install hugo sass/sass/sass   # macOS

hugo server -D                      # dev server with drafts, at http://localhost:1313
hugo --gc --minify                 # production build into ./public
```

## Writing content

All posts live in the single `content/posts/` section. Pick an archetype with `--kind`;
each pre-fills the right `categories` and front matter. New posts start as `draft: true` —
flip it to `false` (or set the Draft toggle in the CMS) to publish.

```sh
hugo new content posts/2026-06-14-my-post.md --kind tech            # tech / dev
hugo new content posts/2026-06-14-my-post.md --kind neurodivergence # AuDHD / advocacy
hugo new content posts/2026-06-14-my-post.md --kind notes           # short writes / quick tips
hugo new content posts/2026-06-14-my-post.md --kind random          # personal / off-topic
hugo new content posts/2026-06-14-my-shoot/index.md --kind photography  # photo bundle
```

Filenames are date-prefixed (`YYYY-MM-DD-slug`); the archetype strips the date to build the title.

### Taxonomy

- **categories** (one per post): `tech` · `neurodivergence` · `notes` · `random` · `photography`.
- **tags** (free-form): the fine-grained signal. Browse at `/categories/` and `/tags/`.

### Images

For a post's own images, use a **page bundle** (a folder with `index.md`) and the `photo`
shortcode, which resizes to responsive WebP and sets `width`/`height` to avoid layout shift:

```text
{{</* photo src="wedding.jpg" alt="Wedding kiss" caption="August 2021" */>}}
```

Loose images dropped in `static/posts/` are served as-is (no processing).

### Comments

giscus is configured in `config.yaml` under `params.comments`. It renders only when the
page type is commentable **and** the page hasn't opted out with `comments: false`.

## Editing via the CMS

[Sveltia CMS](https://github.com/sveltia/sveltia-cms) lives at `/admin/` (config in
`static/admin/config.yml`).

- **Locally (no auth):** run `npx @sveltia/cms-proxy-server` next to `hugo server`, then open `http://localhost:1313/admin/`.
- **On the live site:** GitHub Pages can't hold an OAuth secret, so deploy the free
  one-click [`sveltia-cms-auth`](https://github.com/sveltia/sveltia-cms-auth) Cloudflare
  Worker once and set its URL as `backend.base_url` in `static/admin/config.yml`.

## Project layout

```text
.
├── archetypes/         # content templates (tech, neurodivergence, notes, random, photography, default)
├── assets/
│   ├── js/             # app.js + vendor libs, processed & fingerprinted by Hugo Pipes
│   └── scss/           # main.scss (tokens + styles), variables.scss
├── content/
│   ├── about.md        # about page
│   ├── dev.md          # /dev/ landing
│   ├── audhd.md        # /audhd/ landing
│   └── posts/          # all blog posts
├── layouts/
│   ├── _default/       # baseof, single, list, term, taxonomy, landing, li
│   ├── partials/       # head, header, footer, menu, comment, pagination, post-grid, social-icon, coffee-cup
│   ├── shortcodes/     # photo
│   ├── index.html      # home
│   └── 404.html
├── static/
│   ├── admin/          # Sveltia CMS
│   ├── images/         # logo etc.
│   └── posts/          # loose post images
├── config.yaml         # site configuration
└── .github/workflows/  # GitHub Pages build & deploy
```

## Deployment

Push to `main`. [`.github/workflows/main.yml`](.github/workflows/main.yml) checks out the
repo, installs the pinned Hugo extended + Dart Sass, runs `hugo --gc --minify`, and
publishes `./public` to the `gh-pages` branch.
