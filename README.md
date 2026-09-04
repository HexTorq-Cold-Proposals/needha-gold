# needha-gold — outfit.hellohello.is (Offline Mirror)

Static offline mirror of `https://outfit.hellohello.is` — ready for **Vercel** static hosting.

## Stack
- Pure static HTML/CSS/JS (Next.js static export, pre-rendered)
- `_next/` — Next.js chunks, turbopack assets, optimized images
- `cdn/` — mirrored Shopify + GTM assets
- `product/` — 13 product pages (`product/*.html`)
- No build step required

## Local Preview
```bash
# Python
py -3 -m http.server 8080
# or
python -m http.server 8080

# PowerShell (auto-picks Python / npx serve)
.\serve.ps1

# Node
npx serve . -s --no-clipboard
# or
.\serve.bat
```
Open http://localhost:8080

## Deploy to Vercel

### Option A — Git (recommended)
1. Push to GitHub (already done: `HexTorq-Cold-Proposals/needha-gold`)
2. Vercel Dashboard → **Add New → Project** → Import `needha-gold`
3. Settings:
   - **Framework Preset:** `Other` (auto via `vercel.json` → `framework: null`)
   - **Build Command:** *(empty)* — overridden by `vercel.json`
   - **Output Directory:** `.`
   - **Install Command:** *(empty)*
4. Deploy — no build, Vercel serves static files directly.

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/HexTorq-Cold-Proposals/needha-gold)

### Option B — CLI
```bash
npm i -g vercel
vercel --prod
# or
npx vercel --prod
```

### Vercel Config (`vercel.json`)
- `cleanUrls: true` → `/bag` serves `bag.html`, `/product/command-k` serves `product/command-k.html`
- `trailingSlash: false`
- `framework/build/install` → `null` (pure static, no npm)
- `headers` → immutable cache for `/_next/static/*`, images, `cdn/*`
- `rewrites` → explicit mappings for `/bag`, `/product/*`, `/shipping-and-return`, `/data-sharing-opt-out`

See `vercel.json:1` for full config.

## Routes
- `/` → `index.html`
- `/bag` → `bag.html`
- `/product/:slug` → `product/:slug.html` (e.g. `/product/command-k`)
- `/shipping-and-return` → `shipping-and-return.html`
- `/data-sharing-opt-out` → `data-sharing-opt-out.html`
- `/_next/*`, `/cdn/*`, `/*.webp` etc. — static assets

## Project Structure
```
.
├── index.html
├── bag.html
├── product/           # 13 static product pages
├── _next/             # Next static chunks + optimized images
├── cdn/               # mirrored external CDN
├── preloader/         # preloader images
├── vercel.json        # Vercel static hosting config
├── serve.ps1 / serve.bat  # local preview
└── README.md
```

## Notes
- No `package.json` needed — static deploy skips install/build.
- If you add a framework later, remove `framework/buildCommand` overrides in `vercel.json`.
- Images under `_next/image-*` and root `*.webp` are already optimized.
- Original source: `outfit.hellohello.is` via `website-downloader` tool.

## License
Mirror for demonstration. Original content © hellohello / OUTFITAr.
