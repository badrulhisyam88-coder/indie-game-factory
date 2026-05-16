# Shared Godot addons

Plugins you reuse across multiple games. Add when you've copied the same
addon into 3+ games.

## Currently shared

_none yet_

## Pattern

When you find yourself reusing an addon:
1. Move it to `shared/godot-addons/<addon-name>/`
2. In each game's `godot/addons/`, symlink it:
   `ln -s ../../../../shared/godot-addons/<addon-name> <addon-name>`
3. (On Windows, copy instead of symlink, or use junctions)
