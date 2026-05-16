# CLAUDE.md — 002-kakak-jagung-melaka

> Per-game context. Read this at the start of any Claude Code session
> involving this game.

## What this game is

A mobile-browser idle game built as a gift for my real sister, who runs
Kakak Jagung at a roadside kiosk near Muzium Samudera in Melaka. Customers
will play it via QR code while waiting for their order.

## Concept reference

Full concept: `../../concepts/002-kakak-jagung-melaka.md` — read it before
making any design decisions.

## Build approach

**Path B (from scratch)** — not scaffolded from `templates/game-types/idle-base/`.
Structural differences make a fresh build cleaner than retrofitting.

What we keep from template-style patterns:
- CONSTANTS block at top of main.gd
- Single scene, single script
- Save/load via Godot's `user://` JSON
- Web export preset

## Current status

Phase: scaffolding folder structure (no code yet)

## Tech stack

- Godot 4.6.2-stable
- GDScript only
- Single scene (main.tscn), single script (main.gd)
- HTML5 web export
- Save format: JSON in user:// (per-browser, per-device)

## Mechanics checklist

- [ ] Manual click: 🌽 Buat Jagung → makes 1 cup → auto-sells at best price
- [ ] Money (RM) accumulator
- [ ] Flavor unlock chain (7 items, Ori → Biscoff)
- [ ] Lagi Laju upgrade (+1 per click, max 5 levels)
- [ ] Adik Tolong helper (+1 auto-click/sec, max 3 helpers)
- [ ] Win condition (all 7 flavors unlocked → win screen)
- [ ] Save/load
- [ ] Mobile-friendly layout (touch targets ≥80px)

## Anti-scope (DO NOT BUILD in v1)

Per concept:
- Prestige / branch expansion
- Flavor selector (auto-sell best is fine)
- Real photos
- Custom art beyond emoji
- Sound effects or music
- Customer queue / customer types
- Text input anywhere
- Cloud save / accounts

## Numbers in play

(Empty — populated when main.gd is written)

| Constant | Value | Why |
|----------|-------|-----|

## Tone reminder

Warm, sincere, not hype. Header formal ("KAKAK JAGUNG"), win line warm
("Akak Jagung Melaka"). No screen-shake. No big particle explosions.
Quiet juice.
