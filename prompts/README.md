# Prompts

Your prompt library. This is the real IP of the factory.

## Structure

- `library/` — reusable prompts, numbered for ordering
- `meta/` — prompts about improving prompts
- `used/` — archived session prompts worth keeping

## Naming

`NN-verb-noun.md` — e.g., `01-scaffold-idle.md`, `04-write-captions.md`

## Anatomy of a prompt file

```
# Title

## When to use
(Specific trigger)

## Input variables
- {{VAR_NAME}}: description

## The prompt
(The actual prompt text with {{VARIABLES}})

## Notes from past use
(Append after each session)
```

## Hygiene

- Update "Notes from past use" after every session
- Prune unused prompts monthly
- Keep variables in `{{DOUBLE_BRACES}}` for easy find/replace
