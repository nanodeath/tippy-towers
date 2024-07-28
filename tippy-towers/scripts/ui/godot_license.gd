extends Label

func _ready():
	text = "This game uses Godot Engine, available under the following license:\n"
	text += Engine.get_license_text()
	text += "\n\nAdditional Godot Engine-related licenses:"
	var licenses := Engine.get_license_info()
	for license in licenses:
		text += "\n\n" + license + ":"
		text += "\n" + licenses[license]
