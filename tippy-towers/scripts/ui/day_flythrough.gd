class_name DayFlythrough extends RichTextLabel

@onready var day_manager = %DayManager

func _ready():
	trigger(day_manager.current_day + 1)
	day_manager.new_day.connect(func(d): trigger(d+1))

func trigger(day: int):
	text = "Day " + str(day)
	var width := get_content_width()
	var viewport_size := get_viewport().size as Vector2i
	global_position = Vector2(-width, viewport_size.y / 2 - get_content_height() / 2)
	var center_position := Vector2(viewport_size.x / 2 - width / 2 , global_position.y)
	var final_position := Vector2(global_position.x + viewport_size.x + width, global_position.y)
	
	var tween = create_tween().set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "position", center_position, 1.25).set_ease(Tween.EASE_OUT)
	tween.tween_interval(1.0)
	tween.tween_property(self, "position", final_position, 1).set_ease(Tween.EASE_IN)
