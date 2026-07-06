---
name: personal-site-favicons
description: Use when editing favicon, site icon, apple touch icon, or related metadata for Isaac Salzman's personal site.
---

# Personal Site Favicons

## Required Paths

Update this site's favicon references to these root-level paths exactly:

- `/favicon.ico`
- `/favicon.svg`
- `/favicon-96x96.png`
- `/apple-touch-icon.png`

Use these paths anywhere the site declares favicons or touch icons, including HTML `<head>` links, framework metadata/head config, route metadata, document templates, and manifest-adjacent references.

Replace nested, relative, generated-asset, or build-output favicon paths when they appear. Do not change the actual favicon asset filenames unless the user explicitly asks for asset work.
