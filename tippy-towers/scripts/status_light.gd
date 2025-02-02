class_name StatusLight extends AnimatedSprite2D

@onready var brightness = $Brightness

func _ready():
	brightness.modulate = Color.TRANSPARENT

func turn_on():
	play("on")
	brightness.modulate = Color.TRANSPARENT
	var tween = create_tween()
	tween.tween_property(brightness, "modulate", Color.WHITE, 0.25)
	
func turn_off():
	play("default")
	var tween = create_tween()
	tween.tween_property(brightness, "modulate", Color.TRANSPARENT, 0.5)
