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

const ALL_FLAVORS: Array[String] = [
	"ori", "susu", "susu_cheese", "oreo", "milo", "nutella", "biscoff"
]

# ---------- STATE ----------
var money: int = 0
var unlocked_flavors: Array[String] = ["ori"]
var laju_level: int = 0
var helpers: int = 0
var total_jagung_made: int = 0
var start_time_ms: int = 0
var total_play_seconds: int = 0  # cumulative across sessions
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
	load_game()
	start_time_ms = Time.get_ticks_msec()
	brew_button.pressed.connect(on_brew)
	laju_button.pressed.connect(on_buy_laju)
	helper_button.pressed.connect(on_buy_helper)
	tick_timer.wait_time = AUTO_TICK_INTERVAL
	tick_timer.timeout.connect(on_tick)
	tick_timer.start()
	refresh_ui()
	if game_won:
		show_win_screen()

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
	save_game()
	refresh_ui()

func on_buy_helper() -> void:
	if helpers >= MAX_HELPERS:
		return
	var cost: int = ADIK_TOLONG_COSTS[helpers]
	if money < cost:
		return
	money -= cost
	helpers += 1
	save_game()
	refresh_ui()

func on_unlock_flavor(flavor_id: String) -> void:
	if flavor_id in unlocked_flavors:
		return  # already unlocked, defensive
	var cost: int = _unlock_cost_for(flavor_id)
	if cost <= 0:
		return  # unknown flavor, defensive
	if money < cost:
		return
	money -= cost
	unlocked_flavors.append(flavor_id)
	save_game()
	refresh_ui()
	check_win()

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

func _unlock_cost_for(flavor_id: String) -> int:
	match flavor_id:
		"susu": return UNLOCK_COST_SUSU
		"susu_cheese": return UNLOCK_COST_SUSU_CHEESE
		"oreo": return UNLOCK_COST_OREO
		"milo": return UNLOCK_COST_MILO
		"nutella": return UNLOCK_COST_NUTELLA
		"biscoff": return UNLOCK_COST_BISCOFF
		_: return 0  # "ori" starts unlocked; unknown flavors return 0

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

# ---------- WIN ----------
func check_win() -> void:
	if game_won:
		return
	for flavor in ALL_FLAVORS:
		if flavor not in unlocked_flavors:
			return  # not all unlocked yet
	game_won = true
	show_win_screen()
	save_game()

func show_win_screen() -> void:
	# Compute elapsed (cumulative + current session)
	var session_seconds: int = (Time.get_ticks_msec() - start_time_ms) / 1000
	var elapsed: int = total_play_seconds + session_seconds
	var minutes: int = elapsed / 60
	var seconds: int = elapsed % 60

	# Populate win screen labels (assumes scene has these nodes)
	var made_label: Label = win_screen.get_node("VBox/MadeLabel")
	var money_label_win: Label = win_screen.get_node("VBox/MoneyLabel")
	var time_label: Label = win_screen.get_node("VBox/TimeLabel")
	made_label.text = "Total jagung dibuat: %d" % total_jagung_made
	money_label_win.text = "Total RM: %d" % money
	time_label.text = "Masa: %02d:%02d" % [minutes, seconds]

	win_screen.visible = true
	tick_timer.stop()  # freeze the game on win

# ---------- SAVE / LOAD ----------
func save_game() -> void:
	# Accumulate session time into cumulative before saving
	var now_ms: int = Time.get_ticks_msec()
	total_play_seconds += (now_ms - start_time_ms) / 1000
	start_time_ms = now_ms

	var data := {
		"money": money,
		"unlocked_flavors": unlocked_flavors,
		"laju_level": laju_level,
		"helpers": helpers,
		"total_jagung_made": total_jagung_made,
		"total_play_seconds": total_play_seconds,
		"game_won": game_won,
	}
	var f := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if f == null:
		return  # silent fail — better than crashing in browser
	f.store_string(JSON.stringify(data))
	f.close()

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var f := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if f == null:
		return
	var text: String = f.get_as_text()
	f.close()
	var parsed = JSON.parse_string(text)
	if typeof(parsed) != TYPE_DICTIONARY:
		return  # corrupt save; ignore

	money = int(parsed.get("money", 0))
	laju_level = int(parsed.get("laju_level", 0))
	helpers = int(parsed.get("helpers", 0))
	total_jagung_made = int(parsed.get("total_jagung_made", 0))
	total_play_seconds = int(parsed.get("total_play_seconds", 0))
	game_won = bool(parsed.get("game_won", false))

	# Restore unlocked_flavors with type guard
	var saved_flavors = parsed.get("unlocked_flavors", ["ori"])
	if saved_flavors is Array:
		unlocked_flavors.clear()
		for flavor_id in saved_flavors:
			if flavor_id is String:
				unlocked_flavors.append(flavor_id)
		if unlocked_flavors.is_empty():
			unlocked_flavors = ["ori"]  # never start with nothing unlocked
