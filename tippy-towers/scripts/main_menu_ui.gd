class_name MainMenuUi extends Container

@onready var play_button = $VBoxContainer/PlayButton
@onready var by_line = $ByLine

@onready var main_menu = $".."
@onready var parallax_layer = $"../ParallaxBackground/ParallaxLayer"

func _ready():
	play_button.pressed.connect(self._play_button_pressed)
	play_button.modulate = Color.TRANSPARENT
	by_line.modulate = Color.TRANSPARENT
	var tween := create_tween()
	tween.tween_interval(2)
	tween.tween_property(by_line, "modulate", Color.WHITE, 1)
	tween.tween_interval(1)
	tween.tween_property(play_button, "modulate", Color.WHITE, 1)

func _play_button_pressed():
	var tween := create_tween()
	tween.tween_property(main_menu, "modulate", Color.TRANSPARENT, 1)
	tween.parallel().tween_property(parallax_layer, "modulate", Color.TRANSPARENT, 1)
	tween.tween_callback(func(): get_tree().change_scene_to_file("res://game.tscn"))
