extends Control
# main.gd — Kakak Jagung @ Muzium Samudera

# ---------- CONSTANTS ----------
const ORI_PRICE: int = 4
const SUSU_PRICE: int = 6
const SUSU_CHEESE_PRICE: int = 8
const OREO_PRICE: int = 10
const MILO_PRICE: int = 10
const NUTELLA_PRICE: int = 10
const BISCOFF_PRICE: int = 10

const UNLOCK_COST_SUSU: int = 20
const UNLOCK_COST_SUSU_CHEESE: int = 100
const UNLOCK_COST_OREO: int = 300
const UNLOCK_COST_MILO: int = 800
const UNLOCK_COST_NUTELLA: int = 2000
const UNLOCK_COST_BISCOFF: int = 5000

const LAGI_LAJU_COSTS: Array = [50, 150, 400, 1000, 2500]
const ADIK_TOLONG_COSTS: Array = [100, 500, 2000]
const MAX_LAJU_LEVELS: int = 5
const MAX_HELPERS: int = 3

const AUTO_TICK_INTERVAL: float = 1.0
const SAVE_PATH: String = "user://kakak_jagung_save.json"

# ---------- STATE ----------
var money: int = 0
var unlocked_flavors: Array[String] = ["ori"]
var laju_level: int = 0
var helpers: int = 0
var total_jagung_made: int = 0
var start_time_ms: int = 0
var game_won: bool = false

# ---------- NODES ----------
@onready var money_label: Label = $VBox/MoneyLabel
@onready var jagung_count_label: Label = $VBox/JagungCountLabel
@onready var brew_button: Button = $VBox/BrewButton
@onready var laju_button: Button = $VBox/LajuButton
@onready var helper_button: Button = $VBox/HelperButton
@onready var unlock_buttons_container: VBoxContainer = $VBox/UnlockButtonsContainer
@onready var tick_timer: Timer = $TickTimer
@onready var win_screen: Control = $WinScreen

# ---------- LIFECYCLE ----------
func _ready() -> void:
	start_time_ms = Time.get_ticks_msec()
	brew_button.pressed.connect(on_brew)
	laju_button.pressed.connect(on_buy_laju)
	helper_button.pressed.connect(on_buy_helper)
	tick_timer.wait_time = AUTO_TICK_INTERVAL
	tick_timer.timeout.connect(on_tick)
	tick_timer.start()
	refresh_ui()

# ---------- ACTIONS ----------
func on_brew() -> void:
	money += current_best_price() * (1 + laju_level)
	total_jagung_made += 1
	refresh_ui()

func on_buy_laju() -> void:
	if laju_level >= MAX_LAJU_LEVELS:
		return
	var cost: int = LAGI_LAJU_COSTS[laju_level]
	if money < cost:
		return
	money -= cost
	laju_level += 1
	refresh_ui()

func on_buy_helper() -> void:
	if helpers >= MAX_HELPERS:
		return
	var cost: int = ADIK_TOLONG_COSTS[helpers]
	if money < cost:
		return
	money -= cost
	helpers += 1
	refresh_ui()

func on_unlock_flavor(flavor_id: String) -> void:
	pass  # deduct unlock cost, append to unlocked_flavors, save_game(), refresh_ui(), check_win()

func on_tick() -> void:
	if helpers > 0:
		money += current_best_price() * helpers
		total_jagung_made += helpers
		refresh_ui()

# ---------- HELPERS ----------
func current_best_price() -> int:
	var prices := {
		"ori": ORI_PRICE, "susu": SUSU_PRICE, "susu_cheese": SUSU_CHEESE_PRICE,
		"oreo": OREO_PRICE, "milo": MILO_PRICE, "nutella": NUTELLA_PRICE, "biscoff": BISCOFF_PRICE
	}
	var best := 0
	for flavor in unlocked_flavors:
		if prices.has(flavor):
			best = max(best, prices[flavor])
	return best

func refresh_ui() -> void:
	money_label.text = "RM %d" % money
	jagung_count_label.text = "🌽 %d" % total_jagung_made
	brew_button.text = "🌽 Buat Jagung (+RM %d)" % (current_best_price() * (1 + laju_level))
	if laju_level >= MAX_LAJU_LEVELS:
		laju_button.text = "⚡ Lagi Laju (MAX)"
		laju_button.disabled = true
	else:
		laju_button.text = "⚡ Lagi Laju Lv%d (RM %d)" % [laju_level + 1, LAGI_LAJU_COSTS[laju_level]]
		laju_button.disabled = money < LAGI_LAJU_COSTS[laju_level]
	if helpers >= MAX_HELPERS:
		helper_button.text = "👩‍🍳 Adik Tolong (MAX)"
		helper_button.disabled = true
	else:
		helper_button.text = "👩‍🍳 Adik Tolong %d/3 (RM %d)" % [helpers + 1, ADIK_TOLONG_COSTS[helpers]]
		helper_button.disabled = money < ADIK_TOLONG_COSTS[helpers]

func check_win() -> void:
	pass  # if all 7 flavors unlocked and not game_won, set game_won and call show_win_screen()

func show_win_screen() -> void:
	pass  # populate win labels (made, money, elapsed time), make win_screen visible

# ---------- SAVE / LOAD ----------
func save_game() -> void:
	pass  # write money, unlocked_flavors, laju_level, helpers, total_jagung_made to JSON

func load_game() -> void:
	pass  # restore state from save file; no-op if absent
