class_name Camera extends Camera2D

@onready var camera_target = %CameraTarget

var tween: Tween
var target_position: Vector2

func _process(delta):
	#global_position = lerp(global_position, camera_target.global_position, 2 * delta)
	pass

func move_up(target_global_position: Vector2):
	if target_global_position.y < global_position.y and target_position != target_global_position:
		target_position = target_global_position
		if tween and tween.is_valid():
			tween.kill()
		tween = create_tween()
		var real_target := global_position
		real_target.y = target_global_position.y
		tween.tween_property(self, "global_position", real_target, 1.0)
