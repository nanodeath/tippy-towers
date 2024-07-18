extends ParallaxBackground

func _process(delta):
	scroll_offset.x -= 5.0 * delta
	scroll_offset.y += 15 * delta
