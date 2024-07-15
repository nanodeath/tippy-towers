class_name HighestPointDetector extends ShapeCast2D

#@onready var camera_target = %CameraTarget

func _process(delta):
	var distance_to_collision = get_closest_collision_unsafe_fraction()
	#print("distance_to_collision: ", distance_to_collision, ", in px: ", distance_to_collision * target_position.y)
	if get_collision_count() > 0:
		var first_collision := get_collider(0) as RigidBody2D
		var highest_point := get_collision_point(0) as Vector2
		if first_collision.sleeping:
			%Camera2D.move_up(highest_point)
			%HeightAchieved.update_height(-(highest_point.y - %GroundMarker.global_position.y))
	pass
