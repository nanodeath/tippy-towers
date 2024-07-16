class_name Spawner extends Node2D

@export var to_spawn: Array[PackedScene]
@onready var spawn_timer = %SpawnTimer
@onready var packages_scored := %PackagesScored as PackagesScored

var current_spawner_group: SpawnerGroup

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

func _update_current_group():
	var packages_stacked := packages_scored.packages_scored
	for c in get_children():
		var spawner_group := c as SpawnerGroup
		if packages_stacked >= spawner_group.package_threshold:
			current_spawner_group = spawner_group
