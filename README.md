# davidvoland.com

Personal/project website for [davidvoland.com](https://davidvoland.com).

This repository is **only the website**. QuickMark, Dash Timer, and other apps still live in their Xcode projects and still ship to the App Store through Xcode. GitHub does not replace TestFlight or App Store Connect.

## Local preview

You can open any HTML file in a browser. A local server is a little closer to the live site:

```bash
cd ~/davidvoland.com
python3 -m http.server 8000
```

Then visit [http://localhost:8000](http://localhost:8000).

## What’s on the site

| URL | File | Purpose |
| --- | --- | --- |
| `/` | `index.html` | Homepage |
| `/quickmark/` | `quickmark/index.html` | QuickMark marketing page (App Store Marketing URL) |
| `/quickmark/support` | `quickmark/support.html` | QuickMark support (App Store Support URL) |
| `/quickmark/privacy` | `quickmark/privacy.html` | QuickMark privacy policy (App Store Privacy Policy URL) |
| `/dashtimer/` | `dashtimer/index.html` | Short pointer to [dashtimer.com](https://www.dashtimer.com) |

Shared look: `css/styles.css`. Images: `assets/`.

## How to update the site

1. Edit the HTML or CSS (or ask an AI coding tool to do it).
2. Preview locally.
3. Commit and push to `main`.
4. GitHub Pages publishes in a minute or two.

There is no build step and no database.

## Add another app later

1. Copy `quickmark/` to a new folder such as `futureapp/` (full landing + support + privacy), or copy `dashtimer/` if it only needs a short pointer.
2. Replace the copy, icon, and screenshots.
3. Add a project card on `index.html`.

## QuickMark screenshots

iPhone marketing screenshots live in `quickmark/assets/` and are shown on `/quickmark/`.

## App Store badge

QuickMark currently uses a [TestFlight](https://testflight.apple.com/join/UVaRaFZU) join link. When a real App Store URL exists, replace it with [Apple’s official badge](https://developer.apple.com/app-store/marketing/guidelines/). Do not use a fake store URL.

## First-time GitHub and domain setup

The site files already exist on this Mac at `~/davidvoland.com`. Hosting is free GitHub Pages. Keep the domain registered at GoDaddy.

### 1. GitHub account

If you do not already have one, create a free account at [github.com/signup](https://github.com/signup).

### 2. Create the repository

On GitHub: **New repository**

- Name: `davidvoland.com`
- Public
- Do not add a README, .gitignore, or license (this folder already has them)

### 3. Push this folder

In Terminal (replace `YOUR_USERNAME`):

```bash
cd ~/davidvoland.com
git init
git add .
git commit -m "Initial website"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/davidvoland.com.git
git push -u origin main
```

GitHub may ask you to sign in the first time.

### 4. Enable GitHub Pages

In the repository: **Settings → Pages**

- Source: **Deploy from a branch**
- Branch: `main` / `/ (root)`
- Save
- Custom domain: `davidvoland.com` → Save
- After DNS works, check **Enforce HTTPS**

The `CNAME` file in this repo is already set to `davidvoland.com`.

### 5. GoDaddy DNS

In GoDaddy DNS for `davidvoland.com`, remove parked/default A or CNAME records that conflict, then add:

**A records** (Host `@`):

- `185.199.108.153`
- `185.199.109.153`
- `185.199.110.153`
- `185.199.111.153`

**AAAA records** (Host `@`, recommended):

- `2606:50c0:8000::153`
- `2606:50c0:8001::153`
- `2606:50c0:8002::153`
- `2606:50c0:8003::153`

**CNAME** (Host `www`):

- Points to `YOUR_USERNAME.github.io`

A TTL of 600 seconds is fine while setting this up.

GitHub Pages will use `https://davidvoland.com` as the canonical address and redirect `www.davidvoland.com` there.

DNS can take a few minutes to a few hours. **Enforce HTTPS** can take up to 24 hours to become available.

### 6. App Store Connect URLs (QuickMark)

Once HTTPS works:

- Marketing URL: `https://davidvoland.com/quickmark/`
- Support URL: `https://davidvoland.com/quickmark/support`
- Privacy Policy URL: `https://davidvoland.com/quickmark/privacy`

Leave Dash Timer’s App Store URLs pointing at dashtimer.com.
