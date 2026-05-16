# METHOD — How this factory operates

This is your operating manual. Re-read it monthly. If the system drifts from
what's written here, fix one or the other — they must match.

## Mission

Ship small playable games rapidly. Turn each into social content.
Learn what attracts engagement. Compound the templates and prompts over time.

## The loop

```
concept → scaffold → AI-assisted code → playtest → capture → caption → publish → reflect
```

A full loop should take **5-10 working days** by game #3.
Game #1 may take 14 days. That is fine. Game #1 exists to expose pipeline gaps.

## Rules (hold these — they prevent drift)

1. **Rule of three.** Don't abstract or templatize until you've built the same
   thing three times. Hardcode first.
2. **Tools must replace pain, not anticipate it.** No "I'll need this later"
   installations. Name the specific pain, then install.
3. **Time-box automation.** Max 2 hours on any pipeline improvement. If it
   isn't working in 2 hours, stay manual and try again later.
4. **Ship every week.** Either a game milestone or a content post. No empty
   weeks. Empty weeks compound into dead projects.
5. **Kill stuck games at 14 days.** If a game hasn't progressed in 2 weeks,
   write the postmortem and move on.
6. **Monthly review.** Last day of month, 30 minutes:
   - Games shipped this month?
   - Posts published?
   - Time on tooling vs games? (tooling should be <30%)
   - Any prompt unused? Delete.
   - Any script unrun? Delete.
   - Does METHOD.md still match reality?

## What gets automated vs stays manual

**Manual forever (your taste = the moat):**
- Concept selection
- Identifying which gameplay moments to clip
- Final caption choice
- Publishing to platforms

**Automated:**
- Project scaffolding (new-game.sh)
- Web builds + deployment (GitHub Actions)
- Video format conversion (ffmpeg via clip.sh)

**Semi-automated (AI assists, you decide):**
- Code writing (Claude generates, you review/run)
- Caption drafting (Claude generates 3 variants, you pick/edit)

## Warning signs you're drifting

If you notice any of these, STOP and audit:

- [ ] Haven't shipped a game in 3+ weeks
- [ ] Researching tools instead of building games
- [ ] `tools/` has scripts you can't immediately explain
- [ ] You feel the urge to "rewrite the pipeline properly"
- [ ] More than one new tool added this month
- [ ] METHOD.md hasn't been re-read in 60+ days

## The kill switch

If the system ever feels heavier than just opening Godot and coding, delete
tooling until it feels lighter. The factory exists to accelerate shipping.
The day it slows shipping, gut it.
