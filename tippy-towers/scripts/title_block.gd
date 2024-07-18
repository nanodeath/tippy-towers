class_name TitleBlock extends RigidBody2D

@export_range(-360, 360) var min_angle_deg: float
@export_range(-360, 360) var max_angle_deg: float

func _ready():
	var random_rotation := randf_range(min_angle_deg, max_angle_deg)
	global_rotation_degrees = random_rotation
