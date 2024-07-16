class_name Spawner extends Node2D

@export var to_spawn: Array[PackedScene]
@onready var spawn_timer = %SpawnTimer

var current_spawner_group: SpawnerGroup
var packages_spawned := 0

func _ready():
	spawn.call_deferred()
	spawn_timer.tick.connect(self.spawn)
	_update_current_group()

func spawn():
	_update_current_group()
	var instance := current_spawner_group.to_spawn.pick_random().instantiate() as Node2D
	instance.position = position
	instance.rotation = randf_range(0, PI * 2)
	add_sibling(instance)
	packages_spawned += 1

func _update_current_group():
	for c in get_children():
		var spawner_group := c as SpawnerGroup
		if packages_spawned >= spawner_group.package_threshold:
			current_spawner_group = spawner_group
