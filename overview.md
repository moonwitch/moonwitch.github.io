# Hugo, explained simply

A plain-language tour of the words Hugo throws at you — *archetype, section, taxonomy,
term, partial, shortcode* — using your own site (kellyand.coffee) as the example.

No prior knowledge assumed. Read top to bottom once; after that, use the cheat sheet at the end.

---

## The 30-second big picture

Hugo is a **static site generator**. You write posts in plain text (Markdown). Hugo takes
those, pours them into your page designs (templates), and spits out a folder of finished
HTML — the actual website. There's no database and nothing running on a server; it's just
files. GitHub serves those files.

```
   your writing            your designs              the website
  (Markdown files)   +     (HTML templates)    =    (plain HTML files)
   content/                 layouts/                  public/
```

Everything below is just *names for the pieces of those two columns*.

---

## 1. Content — what you write

Your actual writing lives in **`content/`**. Each post is one Markdown file, e.g.
`content/posts/2026-06-14-my-post.md`.

Every file starts with a little settings block at the very top called **front matter**
(between the `---` lines). It's data *about* the post — not the post itself:

```yaml
---
title: "My Post"
date: "2026-06-14"
categories:
  - tech
tags:
  - docker
  - ci
draft: true
---
Here is where the actual writing starts.
```

Think of front matter as the **label on a jar**: title, date, what shelf it belongs on.
The text below it is what's *in* the jar.

---

## 2. Archetype — the cookie cutter for new posts

An **archetype** is a *template for a new content file*. When you run `hugo new`, Hugo
copies the matching archetype and fills in today's date and the title for you, so you don't
retype the same front matter every time.

They live in **`archetypes/`**. Your site has one per category:

```sh
hugo new content posts/2026-06-14-my-post.md --kind tech
```

`--kind tech` means "use `archetypes/tech.md` as the cookie cutter." That file pre-fills
`categories: [tech]` and the standard fields. Your kinds: `tech`, `neurodivergence`,
`notes`, `random`, `photography` (and a fallback `default`).

> **Cookie-cutter analogy:** the archetype is the cutter; each new post is a fresh cookie
> stamped from it. Changing the cutter only affects *future* cookies, never ones already baked.

New posts come out as `draft: true` — they won't appear on the site until you change that to
`false` (or flip the Draft toggle in the CMS).

---

## 3. Section — a folder of content

A **section** is just a top-level folder inside `content/`. Your site has one real section:
**`posts/`**. That's why your blog lives at `kellyand.coffee/posts/`.

Hugo automatically makes a listing page for a section (the page at `/posts/` that shows all
your post cards). The pages `about`, `dev`, and `audhd` aren't sections — they're individual
standalone pages with their own design.

---

## 4. Taxonomy & Term — how posts get grouped

This is the pair that trips everyone up. They're two halves of the same idea: **grouping**.

**Library analogy:**

- A **taxonomy** is a *way of organising* — like "by genre" or "by author." It's the whole
  system, not any single value.
- A **term** is *one specific value* within that system — like the genre "sci-fi" or the
  author "Le Guin."

Your site has **two taxonomies**:

| Taxonomy | What it's for | Terms (the values) |
| --- | --- | --- |
| **categories** | the one big bucket each post belongs in | `tech`, `neurodivergence`, `notes`, `random`, `photography` |
| **tags** | fine-grained keywords, as many as you like | `docker`, `adhd`, `gcp`, … anything |

So in this front matter:

```yaml
categories:
  - tech          # the post's term in the "categories" taxonomy
tags:
  - docker        # two terms in the "tags" taxonomy
  - ci
```

`tech` is a **term**. `categories` is the **taxonomy** it lives in.

### Two kinds of auto-generated page

Hugo builds pages for these automatically:

- **Taxonomy page** = the *index of all terms*. Example: `/categories/` lists every category
  (tech, neurodivergence, …). Like the table of genres at the library entrance.
- **Term page** = *one term's posts*. Example: `/categories/tech/` lists every post tagged
  `tech`. Like walking to the sci-fi shelf and seeing all the sci-fi books.

```
/categories/          ← taxonomy page  (here are all the categories)
/categories/tech/     ← term page      (here are the posts in "tech")
/tags/                ← taxonomy page  (here are all the tags)
/tags/adhd/           ← term page      (here are the posts tagged "adhd")
```

You don't create these by hand — they appear because your posts use those categories and tags.

---

## 5. Layouts — how pages look

If `content/` is *what you write*, **`layouts/`** is *how it's displayed*. These are HTML
templates with placeholders that Hugo fills in. You rarely touch them, but here's the map.

### The frame: `baseof.html`

**`layouts/_default/baseof.html`** is the outer shell every page shares — the `<head>`, the
top navigation, the footer. Think of it as a **picture frame**: the frame stays the same;
only the picture inside changes. Each page type below just supplies the picture.

### Page-type templates

Hugo picks a template based on *what kind of page* it's rendering:

| Template | Renders… | Example URL |
| --- | --- | --- |
| `index.html` | the home page | `/` |
| `_default/single.html` | one individual post | `/posts/2024-06-27-openrgb/` |
| `_default/list.html` | a section listing | `/posts/` |
| `_default/taxonomy.html` | taxonomy **and** term pages | `/categories/`, `/categories/tech/` |
| `_default/landing.html` | the custom `dev` / `audhd` pages | `/dev/` |
| `_default/li.html` | one post "card" in a grid (a building block, not a full page) | — |

### Partials — reusable building blocks

A **partial** is a chunk of template you reuse in many places, so you write it once. Yours
live in **`layouts/partials/`**: `header.html`, `footer.html`, `menu.html`, `comment.html`,
`pagination.html`, `social-icon.html`, etc.

> **Lego analogy:** the footer is one Lego brick. `baseof.html` snaps the same footer brick
> onto every page. Fix the brick once → every page updates.

### Shortcodes — mini-tools you use *inside* your writing

A **shortcode** is a little command you drop into a Markdown post to do something a plain
sentence can't. Yours lives in `layouts/shortcodes/photo.html`, and you call it like this
inside a post:

```text
{{</* photo src="wedding.jpg" alt="Our wedding day" caption="August 2021" */>}}
```

That one line tells Hugo: take `wedding.jpg`, shrink it to web-friendly sizes, and output a
proper responsive `<img>`. The shortcode is the **machine**; that line is you **pressing its
button**.

---

## 6. A couple of bonus words you'll see

- **Page bundle:** a *folder* that holds a post and its own images together (e.g.
  `content/about/` holds `index.md` + the photos). Keeps a post's images next to the post.
  The `photo` shortcode reads images from the bundle.
- **Asset pipeline / fingerprint:** Hugo also processes your CSS/JS — minifying it and adding
  a unique code to the filename (`main.a1b2c3.css`) so browsers always load the newest version
  instead of a stale cached one. Set-and-forget; it just happens at build time.
- **Draft:** `draft: true` = unpublished. It shows up with `hugo server -D` locally but is
  left out of the real site until you set it to `false`.

---

## Cheat sheet

**"I want to…"**

| Goal | Do this |
| --- | --- |
| Start a tech post | `hugo new content posts/YYYY-MM-DD-slug.md --kind tech` |
| Start an AuDHD/advocacy post | `…--kind neurodivergence` |
| Start a quick tip / short note | `…--kind notes` |
| Start a personal/other post | `…--kind random` |
| Start a photo set (with images) | `hugo new content posts/YYYY-MM-DD-slug/index.md --kind photography` |
| Preview the site locally (incl. drafts) | `hugo server -D` → open http://localhost:1313 |
| Publish a post | set `draft: false` in its front matter |
| Put a post in a category | add it under `categories:` in front matter |
| Add keywords | add them under `tags:` |
| Add an optimised image to a post | use a page bundle + `{{</* photo src="..." alt="..." */>}}` |

**Where things live**

| Folder | Holds |
| --- | --- |
| `content/` | your writing (Markdown) |
| `archetypes/` | cookie cutters for new posts |
| `layouts/` | the page designs (templates, partials, shortcodes) |
| `assets/` | CSS and JS (processed by Hugo) |
| `static/` | files served as-is (loose images, the CMS) |
| `public/` | the built website (generated — never edit by hand) |
| `config.yaml` | site-wide settings |

**The mental model, one more time:**
`content/` (what you say) + `layouts/` (how it looks) → Hugo → `public/` (the website).
Everything else — archetypes, taxonomies, terms, partials, shortcodes — is just a named
helper that makes those two folders easier to manage.
