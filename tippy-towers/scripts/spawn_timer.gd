class_name SpawnTimer extends Node

@export var initial_time: float
@export var time_interval: float
@onready var next_item_handle: NextItemHandle = %NextItemHandle

var time_left: float

signal tick

func _ready():
	time_left = initial_time
	next_item_handle.triggered.connect(func(): time_left = 0)

func _physics_process(delta):
	time_left -= delta
	if time_left <= 0:
		emit_signal("tick")
		time_left += time_interval
