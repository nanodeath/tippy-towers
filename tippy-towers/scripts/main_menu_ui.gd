class_name MainMenuUi extends Container

@onready var play_button = $VBoxContainer/PlayButton

func _ready():
	play_button.pressed.connect(self._play_button_pressed)

func _play_button_pressed():
	get_tree().change_scene_to_file("res://game.tscn")
