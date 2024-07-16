extends StaticBody2D

@onready var chute_area = $ChuteArea as Area2D
@onready var chute_status_light := %ChuteStatusLight as StatusLight

var items_in_chute := 0
var items_detected: bool

func _ready():
	chute_area.body_entered.connect(func(body): items_in_chute += 1)
	chute_area.body_exited.connect(func(body): items_in_chute -= 1)

func _process(delta):
	if not items_detected and items_in_chute > 0:
		items_detected = true
		chute_status_light.turn_on()
	if items_detected and items_in_chute == 0:
		items_detected = false
		chute_status_light.turn_off()
