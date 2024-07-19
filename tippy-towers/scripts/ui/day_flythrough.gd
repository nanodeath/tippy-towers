class_name DayFlythrough extends RichTextLabel

@onready var day_manager = %DayManager
@onready var day_flythrough_left = $"../DayFlythroughLeft"
@onready var day_flythrough_center = $"../DayFlythroughCenter"
@onready var day_flythrough_right = $"../DayFlythroughRight"

func _ready():
	day_manager.new_day.connect(func(d): trigger(d+1))

func trigger(day: int):
	visible = true
	text = "Day " + str(day)
	global_position = day_flythrough_left.global_position
	
	var tween = create_tween().set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "global_position", day_flythrough_center.global_position, 1.25).set_ease(Tween.EASE_OUT)
	tween.tween_interval(1.0)
	tween.tween_property(self, "global_position", day_flythrough_right.global_position, 1).set_ease(Tween.EASE_IN)
