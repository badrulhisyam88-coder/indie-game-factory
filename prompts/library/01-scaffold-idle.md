# Scaffold Idle Game

## When to use

After writing a concept markdown file, when you've just run `new-game.sh`
and want Claude to fill in `main.gd` with the actual mechanics.

## Input variables

- {{CONCEPT}}: full content of `concepts/NNN-name.md`
- {{TEMPLATE_CODE}}: contents of `templates/game-types/idle-base/main.gd`

## The prompt

You are helping me scaffold a Godot 4.6 idle game.

Here is the concept:

```
{{CONCEPT}}
```

Here is my current template `main.gd`:

```gdscript
{{TEMPLATE_CODE}}
```

Your task:

1. Rename the generic "resource" to the concept's actual resource (e.g.,
   coffee, bugs, bots). Update labels, save keys, variable names consistently.
2. Adjust the CONSTANTS block to match the "Numbers to tune" section of the
   concept.
3. If the concept implies a different first upgrade or auto-buyer name,
   update button labels and any logic.
4. Do NOT add new mechanics, scenes, or complexity not in the concept.
5. Do NOT add visuals beyond what already exists.
6. Output the complete modified `main.gd` (full file, ready to save).

Constraints:
- Single file, single scene
- Keep under 200 lines
- All numbers stay in the CONSTANTS block
- Preserve the save/load pattern as-is

After the code, list:
- Any nodes I need to rename in the .tscn (only if names changed)
- Three numbers you'd tune first if the game feels off in playtest
- One sentence on what to test first

## Notes from past use

(Add after each use. Date + lesson.)

- _placeholder — fill in after first use_
