extends Control
# main.gd — Coffee Shop Idle

# ---------- TUNABLE CONSTANTS ----------
const START_COFFEE: int = 0
const MANUAL_GAIN: int = 1            # coffee per click
const UPGRADE_BASE_COST: int = 10     # doubles brewing speed
const UPGRADE_COST_MULT: float = 1.5
const BARISTA_BASE_COST: int = 100    # brews 1 coffee/sec
const AUTO_TICK_INTERVAL: float = 1.0
const CLICK_BUTTON_TEXT: String = "☕ Brew Coffee"
const SAVE_PATH: String = "user://coffee_shop_save.json"

# ---------- STATE ----------
var coffee: int = START_COFFEE
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
	click_button.pressed.connect(on_brew)
	upgrade_button.pressed.connect(on_buy_upgrade)
	auto_button.pressed.connect(on_buy_auto)
	tick_timer.wait_time = AUTO_TICK_INTERVAL
	tick_timer.timeout.connect(on_tick)
	tick_timer.start()
	refresh_ui()

# ---------- ACTIONS ----------
func on_brew() -> void:
	coffee += MANUAL_GAIN * manual_multiplier
	refresh_ui()

func on_buy_upgrade() -> void:
	var cost := current_upgrade_cost()
	if coffee >= cost:
		coffee -= cost
		manual_multiplier += 1
		upgrade_count += 1
		save_game()
		refresh_ui()

func on_buy_auto() -> void:
	var cost := BARISTA_BASE_COST
	if coffee >= cost:
		coffee -= cost
		auto_per_tick += 1
		save_game()
		refresh_ui()

func on_tick() -> void:
	if auto_per_tick > 0:
		coffee += auto_per_tick
		refresh_ui()

# ---------- HELPERS ----------
func current_upgrade_cost() -> int:
	return int(UPGRADE_BASE_COST * pow(UPGRADE_COST_MULT, upgrade_count))

func refresh_ui() -> void:
	resource_label.text = "☕ Coffee: %d" % coffee
	click_button.text = CLICK_BUTTON_TEXT
	upgrade_button.text = "Speed Upgrade (cost %d) | x%d brew" % [current_upgrade_cost(), manual_multiplier]
	auto_button.text = "Hire Barista (cost %d) | %d/sec" % [BARISTA_BASE_COST, auto_per_tick]

# ---------- SAVE / LOAD ----------
func save_game() -> void:
	var data := {
		"coffee": coffee,
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
	coffee = int(parsed.get("coffee", START_COFFEE))
	manual_multiplier = int(parsed.get("manual_multiplier", 1))
	upgrade_count = int(parsed.get("upgrade_count", 0))
	auto_per_tick = int(parsed.get("auto_per_tick", 0))
