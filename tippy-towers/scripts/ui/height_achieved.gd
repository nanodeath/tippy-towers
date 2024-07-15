class_name HeightAchieved extends Container

@onready var height_pixels = $HeightPixels

func update_height(height: float):
	height_pixels.text = str(floori(height))
