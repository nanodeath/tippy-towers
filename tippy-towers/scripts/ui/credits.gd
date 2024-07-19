class_name Credits extends Container

@onready var go_back = $GoBack

signal done

func _ready():
	go_back.pressed.connect(func(): emit_signal("done"))
