class_name Crane extends CharacterBody2D

@export var speed: int
@export var move_up_speed: int
@onready var chain_anchor = $ChainAnchor

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("move_left"):
		position.x -= speed * delta
	elif Input.is_action_pressed("move_right"):
		position.x += speed * delta
	
	if Input.is_action_pressed("move_up"):
		chain_anchor.position.y -= move_up_speed * delta
	elif Input.is_action_pressed("move_down"):
		chain_anchor.position.y += move_up_speed * delta
