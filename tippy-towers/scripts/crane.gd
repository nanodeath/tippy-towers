class_name Crane extends CharacterBody2D

@export var speed: int
@export var move_up_speed: int
@onready var chain_anchor = $ChainAnchor
@onready var gravity_zone = $Magnet/GravityZone

var magnet_activated: bool = false

signal magnet_changed(status: bool)

func _ready():
	_update_magnet()

func _process(delta):
	if Input.is_action_just_pressed("toggle_magnet"):
		magnet_activated = !magnet_activated
		emit_signal("magnet_changed", magnet_activated)
		_update_magnet()

func _physics_process(delta):
	if Input.is_action_pressed("move_left"):
		position.x -= speed * delta
	elif Input.is_action_pressed("move_right"):
		position.x += speed * delta
	
	if Input.is_action_pressed("move_up"):
		chain_anchor.position.y -= move_up_speed * delta
	elif Input.is_action_pressed("move_down"):
		chain_anchor.position.y += move_up_speed * delta

func _update_magnet():
	if magnet_activated:
		gravity_zone.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		gravity_zone.process_mode = Node.PROCESS_MODE_DISABLED
