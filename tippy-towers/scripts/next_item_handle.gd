class_name NextItemHandle extends Node2D

@export var trigger_distance: int = 400
@onready var next_item_handle: RigidBody2D = $NextItemHandle
@onready var chain_anchor: PhysicsBody2D = $ChainAnchor
@onready var chute = %Chute

var is_mouse_down := false
var last_position := Vector2.ZERO
var recently_triggered := false
var chute_occupied := false

signal triggered

func _ready():
	chute.chute_occupied.connect(func(is_occupied: bool): chute_occupied = is_occupied)

func _physics_process(delta):
	var should_allow_force := true
	
	var handle_exceeded_distance := chain_anchor.global_position.distance_to(next_item_handle.global_position) >= trigger_distance
	if handle_exceeded_distance:
		should_allow_force = false
	if not is_mouse_down:
		should_allow_force = false
	if recently_triggered:
		should_allow_force = false
	if chute_occupied:
		should_allow_force = false
	
	if is_mouse_down and not recently_triggered and not chute_occupied and handle_exceeded_distance:
		recently_triggered = true
		emit_signal("triggered")
	if recently_triggered and not is_mouse_down:
		recently_triggered = false

	if should_allow_force:
		var vec := last_position - next_item_handle.global_position
		next_item_handle.apply_force(vec.normalized() * 5 * pow(vec.length(), 2) * delta)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		is_mouse_down = true

func _input(event):
	if event is InputEventMouseButton and not event.is_pressed():
		is_mouse_down = false
	if event is InputEventMouseMotion:
		last_position = event.global_position
