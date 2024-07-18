extends ParallaxBackground

func _process(delta):
	scroll_offset.x -= 20.0 * delta
	scroll_offset.y += 5 * delta
