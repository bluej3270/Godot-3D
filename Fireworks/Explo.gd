extends Particles
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var r = rng.randi_range(1, 6)
	if r == 1:
		get_process_material().color = Color(1, 0, 0, 1)
	elif r == 2:
		get_process_material().color = Color(0, 1, 0, 1)
	elif r == 3:
		get_process_material().color = Color(1, 0, 1, 1)
	elif r == 4:
		get_process_material().color = Color(1, 1, 0, 1)
	elif r == 5:
		get_process_material().color = Color(0, 1, 1, 1)
	else:
		get_process_material().color = Color(0, 0, 1, 1)
	self.set_emitting(true)
