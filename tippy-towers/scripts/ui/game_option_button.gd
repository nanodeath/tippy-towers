extends TextureButton

@onready var options_container = %OptionsContainer
@onready var options_world := %OptionsContainer/OptionsWorld as Options

# Called when the node enters the scene tree for the first time.
func _ready():
	options_container.visible = false
	pressed.connect(self._on_pressed)
	options_world.done.connect(self._on_done)

func _on_pressed():
	options_container.visible = true

func _on_done():
	options_container.visible = false
