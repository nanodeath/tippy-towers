class_name Camera extends Camera2D

@onready var camera_target = %CameraTarget

var tween: Tween
var target_position: Vector2
var transition_duration := 2

func _process(delta):
	#global_position = lerp(global_position, camera_target.global_position, 2 * delta)
	pass

func move_up(target_global_position: Vector2):
	if target_global_position.y < global_position.y and target_position != target_global_position:
		target_position = target_global_position
		if tween and tween.is_valid():
			tween.kill()
		tween = create_tween()
		tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
		tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		var real_target := global_position
		real_target.y = target_global_position.y
		tween.tween_property(self, "global_position", real_target, transition_duration)
		var delta_y := target_global_position.y - global_position.y
		var crane_target_position = %Crane.global_position
		crane_target_position.y += delta_y
		tween.parallel().tween_method(func(new_y): %Crane.global_position.y = new_y, %Crane.global_position.y, crane_target_position.y, transition_duration)
		#tween.parallel().tween_property(%Crane, "global_position", crane_target_position, 1.0)
