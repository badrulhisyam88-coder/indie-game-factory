# Concept: Kakak Jagung @ Muzium Samudera

**Type:** idle
**Estimated scope:** medium (5-7 days, target ~10 min playtime)
**Status:** active

## Context

Built as a gift for my real sister, who runs Kakak Jagung — a roadside
jagung kiosk near Muzium Samudera in Melaka. Deployed via QR code at the
kiosk so customers can play while waiting (typical wait: 2-5 minutes).
Full playthrough should take ~10 minutes for a determined player.

## One-line pitch

A bite-sized idle game about running a real Malaysian jagung kiosk —
unlock all 7 flavors from Ori to Biscoff, end with a thank-you from the
real shop.

## Core loop

- Tap "🌽 Buat Jagung" to make and sell one cup at the current best price
- Money (RM) accumulates
- Unlock new flavors at milestones (each new flavor becomes the new best price)
- Buy upgrades: "Lagi Laju" (click power) and "Adik Tolong" (auto-clicker)

## Real shop menu (mirrored exactly)

| Flavor | Price | Unlock at |
|--------|-------|-----------|
| Jagung Ori | RM4 | free (starter) |
| Jagung Susu | RM6 | RM20 |
| Jagung Susu Cheese 🧀 | RM8 | RM100 (real top seller) |
| Jagung Oreo | RM10 | RM300 |
| Jagung Milo | RM10 | RM800 |
| Jagung Nutella | RM10 | RM2,000 |
| Jagung Biscoff | RM10 | RM5,000 |

## Upgrades

- **Lagi Laju** (+1 per click, max 5 levels) — costs: RM50, 150, 400, 1000, 2500
- **Adik Tolong** (+1 auto-click/sec, max 3 helpers) — costs: RM100, 500, 2000

## Win condition

Unlock all 7 flavors → show win screen.

**Win screen:**
- Header: 🌽
- Body: "Terima Kasih Kerana Membeli\nDari Akak Jagung Melaka"
- Stats: total jagung made, total RM earned, time taken
- Footer: "Dekat Muzium Samudera, Melaka 💛"
- Buttons: [Main Lagi] [Reset]

## Tone & UI

- Mixed BM/English (e.g., "Buat Jagung", "Unlock Susu Cheese", "RM 50")
- Header label: KAKAK JAGUNG (formal brand name)
- Closing label: Akak Jagung Melaka (warm spoken form)
- Warm and sincere — no hype, no screen-shake, no particle explosions
- Emoji-led visuals: 🌽 🥛 🧀 🖤 🟫 🤎 🍪 💛
- Vertical layout (720×1280), finger-friendly buttons

## Progression

- 0–30s: manual tapping, unlock Susu (RM20 milestone)
- ~2 min: Susu Cheese unlocked (RM100) — matches kiosk wait time sweet spot
- ~5 min: first Adik Tolong hired, numbers move on their own
- ~10 min: all 7 flavors unlocked, win screen shown

## Hook (content angle)

"I built an idle game about my sister's corn stall at Muzium Samudera in
Melaka. She doesn't know yet — I'm giving her the QR code next week."

## Numbers to tune

- First unlock milestone (Susu @ RM20) — must hit in ~30s of tapping
- Susu Cheese milestone (RM100) — must hit in ~2 min (matches wait time)
- Lagi Laju cost curve — should feel meaningful per level, not trivial

## Inspirations

- Cookie Clicker (unlock loop)
- Adventure Capitalist (visual idle progression)
- The real Kakak Jagung kiosk, Muzium Samudera, Melaka

## Cut list (what NOT to build)

- Prestige / branch expansion
- Flavor selector (auto-sell best price is fine)
- Real photos of the shop or sister
- Custom art beyond emoji
- Sound effects or music
- Customer queue / customer types
- Mobile-native (stays web-only)
- Text input anywhere
- Cloud save / accounts
- Multiple languages beyond BM-English mix
