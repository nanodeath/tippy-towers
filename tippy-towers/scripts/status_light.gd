class_name StatusLight extends AnimatedSprite2D

@onready var brightness = $Brightness

func _ready():
	turn_on()

func turn_on():
	play("on")
	brightness.modulate = Color.TRANSPARENT
	brightness.visible = true
	var tween = create_tween()
	tween.tween_property(brightness, "modulate", Color.WHITE, 0.25)
	
func turn_off():
	play("default")
	var tween = create_tween()
	tween.tween_property(brightness, "modulate", Color.TRANSPARENT, 0.5)
	tween.tween_callback(func(): brightness.visible = false)
