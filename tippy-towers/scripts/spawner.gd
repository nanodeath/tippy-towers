class_name Spawner extends Node2D

@export var to_spawn: Array[PackedScene]
@export var interval_seconds: float
@onready var spawn_timer = %SpawnTimer

func _ready():
	spawn.call_deferred()
	spawn_timer.tick.connect(self.spawn)

func spawn():
	var instance := to_spawn.pick_random().instantiate() as Node2D
	instance.position = position
	instance.rotation = randf_range(0, PI * 2)
	add_sibling(instance)
