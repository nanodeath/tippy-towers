class_name Box extends RigidBody2D

@export var sprites: Array[Sprite2D]
@onready var noise: Sprite2D = $Noise

func _ready():
	var sprite_to_show := sprites.pick_random() as Sprite2D
	for s in sprites:
		s.visible = s == sprite_to_show
	var noise_texture := noise.texture.duplicate(true) as NoiseTexture2D
	(noise_texture.noise as FastNoiseLite).seed = randi()
	noise.texture = noise_texture
