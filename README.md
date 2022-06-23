# Colors to be used

```sass
$font-main: #031F2D;
$background: #F9F4D7;
$accent-light: #EE8F1E;
$accent-dark: #60160D;
```

# CSS Frameworks

- Normalize.css
- Mini.css
- <link rel="stylesheet" href="https://unpkg.com/wingcss"/>

# Directory structure Explained

```
.
├── archetypes
├── assets (not default created)
├── config.yaml
├── content
├── data
├── layouts
├── static
└── themes
```

## archetypes

Defines new content types (`hugo new`), so are content templates. (Predefined front matter)

## assets

Stores all files which should be processed by Hugo Pipes, will end up in `public`

## content

All markdown content goes here obviously.

## data

Stores config files to be used by Hugo when generating the site. Can be yaml, toml or json. You can also create data templates. Data will be accessible as .Site.Data.xxx

eg. 
```
{{ range $.Site.Data.jazz.bass }}
   {{ partial "artist.html" . }}
{{ end }}
```

## static

Stores all static content; images, css, javascripts. Everything in static is copied over as-is.

## resources

Cached files