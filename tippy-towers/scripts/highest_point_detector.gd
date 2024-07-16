class_name HighestPointDetector extends ShapeCast2D

#@onready var camera_target = %CameraTarget
var current_height: int = 0
var maximum_height: int = 0

func _process(delta):
	var distance_to_collision = get_closest_collision_unsafe_fraction()
	#print("distance_to_collision: ", distance_to_collision, ", in px: ", distance_to_collision * target_position.y)
	if get_collision_count() > 0:
		var first_collision := get_collider(0) as RigidBody2D
		var highest_point := get_collision_point(0) as Vector2
		var height = -(highest_point.y - %GroundMarker.global_position.y)
		current_height = height
		maximum_height = max(maximum_height, height)
		if first_collision.sleeping and not first_collision.is_in_group("scored"):
			first_collision.add_to_group("scored")
			get_node("/root/Game/PackagesScored").packages_scored += 1
			%Camera2D.move_up(highest_point)
			%HeightAchieved.update_height(-(highest_point.y - %GroundMarker.global_position.y))
	pass
