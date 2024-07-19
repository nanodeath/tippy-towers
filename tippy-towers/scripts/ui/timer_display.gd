class_name TimerDisplay extends Container

@onready var time = $Time
@onready var spawn_timer = %SpawnTimer

var override: String

func _ready():
	spawn_timer.tick.connect(func():
		override = "INCOMING"
		var timer := get_tree().create_timer(2.0, false)
		timer.timeout.connect(func(): override = "")
	)

func _process(delta):
	var txt := ""
	var time := spawn_timer.time_left as float
	if time >= 10:
		txt = str(ceili(time))
	elif time >= 5:
		txt = str("%.1f" % time)
	else:
		txt = str("%.2f" % time)
	if override:
		txt = override
	self.time.text = txt
