class_name Crane extends CharacterBody2D

@export var speed: int

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("move_left"):
		position.x -= speed * delta
	elif Input.is_action_pressed("move_right"):
		position.x += speed * delta
