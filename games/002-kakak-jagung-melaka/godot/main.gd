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
	pass  # connect signals, load_game(), start timer, refresh_ui()

# ---------- ACTIONS ----------
func on_brew() -> void:
	pass  # add current_best_price() to money, increment total_jagung_made, refresh_ui(), check_win()

func on_buy_laju() -> void:
	pass  # deduct LAGI_LAJU_COSTS[laju_level], increment laju_level, save_game(), refresh_ui()

func on_buy_helper() -> void:
	pass  # deduct ADIK_TOLONG_COSTS[helpers], increment helpers, save_game(), refresh_ui()

func on_unlock_flavor(flavor_id: String) -> void:
	pass  # deduct unlock cost, append to unlocked_flavors, save_game(), refresh_ui(), check_win()

func on_tick() -> void:
	pass  # call on_brew() once per helper

# ---------- HELPERS ----------
func current_best_price() -> int:
	pass  # return highest price among unlocked_flavors

func refresh_ui() -> void:
	pass  # update all labels and button states

func check_win() -> void:
	pass  # if all 7 flavors unlocked and not game_won, set game_won and call show_win_screen()

func show_win_screen() -> void:
	pass  # populate win labels (made, money, elapsed time), make win_screen visible

# ---------- SAVE / LOAD ----------
func save_game() -> void:
	pass  # write money, unlocked_flavors, laju_level, helpers, total_jagung_made to JSON

func load_game() -> void:
	pass  # restore state from save file; no-op if absent
