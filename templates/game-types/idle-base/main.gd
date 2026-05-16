extends Control
# main.gd — minimal idle game template
# Modify per-game. Keep tunables in the CONSTANTS block.

# ---------- TUNABLE CONSTANTS ----------
const START_RESOURCE: int = 0
const MANUAL_GAIN: int = 1
const UPGRADE_BASE_COST: int = 10
const UPGRADE_COST_MULT: float = 1.5
const AUTO_TICK_INTERVAL: float = 1.0  # seconds
const CLICK_BUTTON_TEXT: String = "Click me"
const SAVE_PATH: String = "user://save.json"

# ---------- STATE ----------
var resource: int = START_RESOURCE
var manual_multiplier: int = 1
var upgrade_count: int = 0
var auto_per_tick: int = 0

# ---------- NODES (assign in editor) ----------
@onready var resource_label: Label = $VBox/ResourceLabel
@onready var click_button: Button = $VBox/ClickButton
@onready var upgrade_button: Button = $VBox/UpgradeButton
@onready var auto_button: Button = $VBox/AutoButton
@onready var tick_timer: Timer = $TickTimer

# ---------- LIFECYCLE ----------
func _ready() -> void:
	load_game()
	click_button.pressed.connect(on_click)
	upgrade_button.pressed.connect(on_buy_upgrade)
	auto_button.pressed.connect(on_buy_auto)
	tick_timer.wait_time = AUTO_TICK_INTERVAL
	tick_timer.timeout.connect(on_tick)
	tick_timer.start()
	refresh_ui()

# ---------- ACTIONS ----------
func on_click() -> void:
	resource += MANUAL_GAIN * manual_multiplier
	refresh_ui()

func on_buy_upgrade() -> void:
	var cost := current_upgrade_cost()
	if resource >= cost:
		resource -= cost
		manual_multiplier += 1
		upgrade_count += 1
		save_game()
		refresh_ui()

func on_buy_auto() -> void:
	var cost := 100  # placeholder — tune per game
	if resource >= cost:
		resource -= cost
		auto_per_tick += 1
		save_game()
		refresh_ui()

func on_tick() -> void:
	if auto_per_tick > 0:
		resource += auto_per_tick
		refresh_ui()

# ---------- HELPERS ----------
func current_upgrade_cost() -> int:
	return int(UPGRADE_BASE_COST * pow(UPGRADE_COST_MULT, upgrade_count))

func refresh_ui() -> void:
	resource_label.text = "Resource: %d" % resource
	click_button.text = CLICK_BUTTON_TEXT
	upgrade_button.text = "Upgrade (cost %d) | x%d click" % [current_upgrade_cost(), manual_multiplier]
	auto_button.text = "Auto (cost 100) | %d/sec" % auto_per_tick

# ---------- SAVE / LOAD ----------
func save_game() -> void:
	var data := {
		"resource": resource,
		"manual_multiplier": manual_multiplier,
		"upgrade_count": upgrade_count,
		"auto_per_tick": auto_per_tick,
	}
	var f := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if f:
		f.store_string(JSON.stringify(data))
		f.close()

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var f := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not f:
		return
	var text := f.get_as_text()
	f.close()
	var parsed = JSON.parse_string(text)
	if typeof(parsed) != TYPE_DICTIONARY:
		return
	resource = int(parsed.get("resource", START_RESOURCE))
	manual_multiplier = int(parsed.get("manual_multiplier", 1))
	upgrade_count = int(parsed.get("upgrade_count", 0))
	auto_per_tick = int(parsed.get("auto_per_tick", 0))
