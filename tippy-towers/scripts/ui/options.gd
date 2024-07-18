class_name Options extends Node2D

@onready var go_back = %GoBack

signal done

func _ready():
	go_back.pressed.connect(func(): emit_signal("done"))
	
	done.connect(func(): get_node("/root/OptionsAutoload").save_preferences())
	
