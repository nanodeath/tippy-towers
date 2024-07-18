class_name Spawner extends Node2D

@export var to_spawn: Array[PackedScene]
@onready var spawn_timer = %SpawnTimer
@onready var day_manager := %DayManager

var current_spawner_group: SpawnerGroup
var packages_spawned := 0

signal package_spawned(count: int)

func _ready():
	spawn_timer.tick.connect(self.spawn)
	_update_current_group()

func spawn():
	_update_current_group()
	var instance := current_spawner_group.to_spawn.pick_random().instantiate() as Node2D
	instance.position = position
	instance.rotation = randf_range(0, PI / 4)
	add_sibling(instance)
	packages_spawned += 1
	emit_signal("package_spawned", packages_spawned)

func _update_current_group():
	var idx = min(day_manager.current_day, get_child_count() - 1)
	current_spawner_group = get_child(idx)
