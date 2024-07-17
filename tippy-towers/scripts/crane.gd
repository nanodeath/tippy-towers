class_name Crane extends CharacterBody2D

@export var speed: int
@export var move_up_speed: int
@export var left_bound: Node2D
@export var right_bound: Node2D
@export var junk_probes: Array[RayCast2D]

@onready var chain_anchor = $ChainAnchor
@onready var gravity_zone: Area2D = $Magnet/GravityZone
@onready var magnet: RigidBody2D = $Magnet
@onready var anchor_min = $AnchorMin
@onready var anchor_max = $AnchorMax
@onready var game: Game
@onready var light = $Magnet/Light

var magnet_activated: bool = false

signal magnet_changed(status: bool)

var fused_with_junk: Array[RigidBody2D] = []

var current_speed := 0.0
var tween_speed := 0.05

func _ready():
	game = get_node("/root/Game")
	_update_magnet()

func _process(delta):
	var is_game_over := game.is_game_over
	if Input.is_action_just_pressed("toggle_magnet") and not is_game_over:
		magnet_activated = !magnet_activated
		emit_signal("magnet_changed", magnet_activated)
		_update_magnet()
	
	if Input.is_action_pressed("move_left") and not is_game_over:
		current_speed = lerpf(current_speed, -speed * delta, tween_speed)
	elif Input.is_action_pressed("move_right") and not is_game_over:
		current_speed = lerpf(current_speed, speed * delta, tween_speed)
	else:
		current_speed = lerpf(current_speed, 0, tween_speed)
		if absf(current_speed) < 0.01:
			current_speed = 0

func _physics_process(delta):
	global_position.x = clampf(position.x + current_speed, left_bound.global_position.x, right_bound.global_position.x)
	
	var contacts := 0
	for probe in junk_probes:
		if probe.is_colliding():
			contacts += 1
	
	if not game.is_game_over:
		if Input.is_action_pressed("move_up"):
			chain_anchor.position.y -= move_up_speed * delta
		elif Input.is_action_pressed("move_down"):
			chain_anchor.position.y += move_up_speed * delta
		chain_anchor.position.y = clampf(chain_anchor.position.y, anchor_min.position.y, anchor_max.position.y)
	
	#print("Magnet contact: ", contact_count)
	if magnet_activated and contacts > 1:
		var collisions := []
		for probe in junk_probes:
			var obj := probe.get_collider()
			if not obj is PhysicsBody2D or not obj.is_in_group("junk"):
				continue
			#print("  collider obj: ", obj)
			if collisions.has(obj):
				# two contacts
				#print("Connecting to ", obj)
				if not fused_with_junk.has(obj):
					var other := obj as RigidBody2D
					other.reparent(magnet)
					other.freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
					other.freeze = true
					other.collision_layer = 1 << 0
					fused_with_junk.push_back(obj)
			else:
				collisions.push_back(obj)
	if not magnet_activated and fused_with_junk.size() > 0:
		for obj in fused_with_junk:
			obj.add_collision_exception_with(magnet)
			obj.reparent(get_parent())
			obj.freeze = false
			obj.collision_layer = 1 << 1
			var timer := Timer.new()
			timer.autostart = true
			timer.wait_time = 1.0
			timer.timeout.connect(func():
				obj.remove_collision_exception_with(magnet)
				timer.queue_free()
			)
			obj.add_child(timer)
		fused_with_junk.clear()

func _update_magnet():
	if magnet_activated:
		gravity_zone.process_mode = Node.PROCESS_MODE_INHERIT
		light.play("on")
	else:
		gravity_zone.process_mode = Node.PROCESS_MODE_DISABLED
		light.play("default")

func _body_entered(body: Node):
	pass
	
func _body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int):
	var other_body_state := PhysicsServer2D.body_get_direct_state(body_rid)
	var my_body_state := PhysicsServer2D.body_get_direct_state(magnet.get_rid())
	var contact_count := my_body_state.get_contact_count()
	#print("Magnet contact count up to: ", contact_count)
	
func _body_shape_exited(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int):
	var other_body_state := PhysicsServer2D.body_get_direct_state(body_rid)
	var my_body_state := PhysicsServer2D.body_get_direct_state(magnet.get_rid())
	var contact_count := my_body_state.get_contact_count()
	#print("Magnet contact count down to: ", contact_count)
