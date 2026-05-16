# Critique Game Design

## When to use

When a game feels "off" in playtest and you can't pin down why.

## Input variables

- {{CONCEPT}}: the concept markdown
- {{CURRENT_NUMBERS}}: the current CONSTANTS block from main.gd
- {{PLAYTEST_NOTES}}: 3-5 bullets about what felt wrong

## The prompt

I'm tuning an idle game. Here's the concept:

```
{{CONCEPT}}
```

Current tunable numbers:

```gdscript
{{CURRENT_NUMBERS}}
```

What felt wrong in playtest:

{{PLAYTEST_NOTES}}

Diagnose, don't just suggest fixes. For each issue:
1. Name the design pattern being violated (e.g., "first dopamine hit too late",
   "upgrade curve too flat", "no meaningful choice at this stage")
2. Identify which 1-2 numbers most likely cause it
3. Propose specific new values
4. Predict what will feel different after the change

Be willing to say "the concept itself is the problem" if true. I'd rather
kill a bad idea fast than tune a broken one.

## Notes from past use
