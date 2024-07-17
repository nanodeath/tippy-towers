class_name NextItemHandle extends Node2D

@export var trigger_distance: int = 420
@onready var next_item_handle: RigidBody2D = $NextItemHandle
@onready var chain_anchor: PhysicsBody2D = $ChainAnchor

var is_mouse_down := false
var last_position := Vector2.ZERO
var recently_triggered := false
signal triggered

func _process(delta):
	if is_mouse_down and not recently_triggered and chain_anchor.global_position.distance_to(next_item_handle.global_position) >= trigger_distance:
		recently_triggered = true
		print("Triggered!")
		emit_signal("triggered")
	elif recently_triggered and not is_mouse_down:
		recently_triggered = false

func _physics_process(delta):
	if is_mouse_down and not recently_triggered:
		var vec := last_position - next_item_handle.global_position
		next_item_handle.apply_force(vec.normalized() * pow(vec.length(), 2))

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		is_mouse_down = true
		print("Mouse down? ", is_mouse_down)

func _input(event):
	if event is InputEventMouseButton and not event.is_pressed():
		is_mouse_down = false
		print("Mouse down2? ", is_mouse_down)
	if event is InputEventMouseMotion:
		last_position = event.global_position
