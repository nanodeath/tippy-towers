extends Control

@onready var packages_placed_count = $PanelContainer/CenterContainer/VBoxContainer/GridContainer/PackagesPlacedCount
@onready var height_achieved_count = $PanelContainer/CenterContainer/VBoxContainer/GridContainer/HeightAchievedCount
@onready var time_elapsed_value = $PanelContainer/CenterContainer/VBoxContainer/GridContainer/TimeElapsedValue
@onready var days_since_last_accident_counter = $PanelContainer/CenterContainer/VBoxContainer/DaysSinceLastAccidentCounter
@onready var package_lost_zone = %PackageLostZone
@onready var day_manager: DayManager = %DayManager
@onready var retry_button = $PanelContainer/CenterContainer/VBoxContainer/RetryButton


func _ready():
	get_node("/root/Game").game_over.connect(activate)
	retry_button.pressed.connect(self._retry_pressed)

func activate():
	visible = true
	packages_placed_count.text = str(%PackagesScored.packages_scored)
	height_achieved_count.text = str(%HighestPointDetector.maximum_height)
	var days := day_manager.current_day + 1
	days_since_last_accident_counter.text = str(days)
	var time_elapsed = %GameStopwatch.time_running
	time_elapsed_value.text = str("%.3f" % time_elapsed) + "s"

func _retry_pressed():
	get_tree().change_scene_to_file("res://game.tscn")
