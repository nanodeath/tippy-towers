class_name Box extends RigidBody2D

@export var sprites: Array[Sprite2D]
@onready var noise: Sprite2D = $Noise

var sfx: AudioStreamPlayer2D

const impact_threshold := 100_000
const max_impact_threshold := 500_000
const min_volume := 0.25
const max_volume := 1

var previous_speed_sq := -1

func _ready():
	var sprite_to_show := sprites.pick_random() as Sprite2D
	for s in sprites:
		s.visible = s == sprite_to_show
	var noise_texture := noise.texture.duplicate(true) as NoiseTexture2D
	(noise_texture.noise as FastNoiseLite).seed = randi()
	noise.texture = noise_texture
	
	sfx = get_node_or_null("SFX")

func _process(_delta):
	if previous_speed_sq < 0:
		previous_speed_sq = linear_velocity.length_squared()
	var current_speed_sq := linear_velocity.length_squared()
	if previous_speed_sq >= current_speed_sq + impact_threshold:
		if sfx != null and not sfx.playing:
			sfx.volume_db = remap(previous_speed_sq - current_speed_sq, impact_threshold, max_impact_threshold, max_volume, min_volume)
			sfx.play()
	previous_speed_sq = current_speed_sq
