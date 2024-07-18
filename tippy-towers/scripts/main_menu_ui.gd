class_name MainMenuUi extends Container

@onready var buttons = $Buttons
@onready var play_button = $Buttons/PlayButton
@onready var options_button = $Buttons/OptionsButton
@onready var by_line = $ByLine

@onready var main_menu = $".."
@onready var options_world = %OptionsWorld

@onready var parallax_layer_2 = $"../../ParallaxBackground/ParallaxLayer2"
@onready var parallax_layer = $"../../ParallaxBackground/ParallaxLayer"

func _ready():
	play_button.pressed.connect(self._play_button_pressed)
	options_button.pressed.connect(self._options_button_pressed)
	options_world.done.connect(self._options_done)
	
	buttons.modulate = Color.TRANSPARENT
	by_line.modulate = Color.TRANSPARENT
	var tween := create_tween()
	tween.tween_interval(2)
	tween.tween_property(by_line, "modulate", Color.WHITE, 1)
	tween.tween_interval(1)
	tween.tween_property(buttons, "modulate", Color.WHITE, 1)
	

func _play_button_pressed():
	var tween := create_tween()
	tween.tween_property(main_menu, "modulate", Color.BLACK, 1)
	tween.parallel().tween_property(parallax_layer, "modulate", Color.BLACK, 1)
	tween.parallel().tween_property(parallax_layer_2, "modulate", Color.BLACK, 1)
	tween.tween_callback(func(): get_tree().change_scene_to_file("res://game.tscn"))

func _options_button_pressed():
	main_menu.visible = false
	options_world.visible = true
	
func _options_done():
	main_menu.visible = true
	options_world.visible = false
