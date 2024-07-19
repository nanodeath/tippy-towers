class_name Box extends RigidBody2D

@export var sprites: Array[Sprite2D]

func _ready():
	var sprite_to_show := sprites.pick_random() as Sprite2D
	for s in sprites:
		s.visible = s == sprite_to_show
