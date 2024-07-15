class_name TimerDisplay extends Container

@onready var time = $Time
@onready var spawn_timer = %SpawnTimer

func _process(delta):
	var txt := ""
	var time := spawn_timer.time_left as float
	if time > 10:
		txt = str(ceili(time))
	elif time >= 5:
		txt = str(snappedf(time, 0.1))
	else:
		txt = str(snappedf(time, 0.01))
	self.time.text = txt
