extends Control

@onready var packages_placed_count = $PanelContainer/CenterContainer/VBoxContainer/GridContainer/PackagesPlacedCount
@onready var height_achieved_count = $PanelContainer/CenterContainer/VBoxContainer/GridContainer/HeightAchievedCount
@onready var days_since_last_accident_counter = $PanelContainer/CenterContainer/VBoxContainer/DaysSinceLastAccidentCounter
@onready var package_lost_zone = %PackageLostZone

func _ready():
	get_node("/root/Game").game_over.connect(activate)

func activate():
	visible = true
	packages_placed_count.text = str(%PackagesScored.packages_scored)
	height_achieved_count.text = str(%HighestPointDetector.maximum_height)
	var days := floori(%HighestPointDetector.maximum_height / 100)
	days_since_last_accident_counter.text = str(days)
