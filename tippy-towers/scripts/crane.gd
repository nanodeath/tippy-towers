class_name Crane extends CharacterBody2D

@export var speed: int
@export var move_up_speed: int
@export var left_bound: Node2D
@export var right_bound: Node2D
@onready var chain_anchor = $ChainAnchor
@onready var gravity_zone: Area2D = $Magnet/GravityZone
@onready var magnet: RigidBody2D = $Magnet
@onready var sticky_bit = $Magnet/StickyBit
@onready var anchor_min = $AnchorMin
@onready var anchor_max = $AnchorMax

var magnet_activated: bool = false

signal magnet_changed(status: bool)

var contacts: int = 0
var magnet_direct_state: PhysicsDirectBodyState2D
var fused_with_junk: Array[RigidBody2D] = []

func _ready():
	_update_magnet()
	magnet_direct_state = PhysicsServer2D.body_get_direct_state(sticky_bit.get_rid())
	
	sticky_bit.body_entered.connect(func(b): contacts += 1)
	sticky_bit.body_exited.connect(func(b): contacts -= 1)

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
	global_position.x = clampf(position.x, left_bound.global_position.x, right_bound.global_position.x)
	
	if Input.is_action_pressed("move_up"):
		chain_anchor.position.y -= move_up_speed * delta
	elif Input.is_action_pressed("move_down"):
		chain_anchor.position.y += move_up_speed * delta
	chain_anchor.position.y = clampf(chain_anchor.position.y, anchor_min.position.y, anchor_max.position.y)
	
	var contact_count := magnet_direct_state.get_contact_count()
	#print("Magnet contact: ", contact_count)
	if magnet_activated and contacts > 0:
		var collisions := []
		for i in contact_count:
			var obj := magnet_direct_state.get_contact_collider_object(i) as Node
			if not obj is PhysicsBody2D or not obj.is_in_group("junk"):
				continue
			#print("  collider obj: ", obj)
			if collisions.has(obj):
				# two contacts
				#print("Connecting to ", obj)
				if not fused_with_junk.has(obj):
					print("Fused with ", obj)
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
			obj.add_collision_exception_with(sticky_bit)
			obj.reparent(get_parent())
			obj.freeze = false
			obj.collision_layer = 1 << 1
			var timer := Timer.new()
			timer.autostart = true
			timer.wait_time = 1.0
			timer.timeout.connect(func():
				obj.remove_collision_exception_with(magnet)
				obj.remove_collision_exception_with(sticky_bit)
				timer.queue_free()
			)
			add_child(timer)
		fused_with_junk.clear()

func _update_magnet():
	if magnet_activated:
		gravity_zone.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		gravity_zone.process_mode = Node.PROCESS_MODE_DISABLED

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
