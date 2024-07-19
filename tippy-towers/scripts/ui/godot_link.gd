extends LinkButton

func _ready():
	text = "Godot " + Engine.get_version_info()["string"]
