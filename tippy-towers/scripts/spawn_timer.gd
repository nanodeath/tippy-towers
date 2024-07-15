class_name SpawnTimer extends Node

@export var initial_time: float

var time_left: float

signal tick

func _ready():
	time_left = initial_time

func _physics_process(delta):
	time_left -= delta
	if time_left <= 0:
		emit_signal("tick")
		time_left += initial_time
