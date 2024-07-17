class_name DayManager extends Node

@export var packages_per_day: int = 10

@onready var spawner = %Spawner

# Days start at 0
var current_day := 0
signal new_day(day: int)

func _ready():
	spawner.package_spawned.connect(self._package_spawned)
	emit_signal("new_day", current_day)

func _package_spawned(count: int):
	var game = get_node("/root/Game") as Game
	var calculated_day: int = count / packages_per_day
	if current_day != calculated_day and not game.is_game_over:
		current_day = calculated_day
		emit_signal("new_day", current_day)
