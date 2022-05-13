extends RigidBody

# Called when the node enters the scene tree for the first time.
func _ready():
	linear_velocity = Vector3(0, 20, 0)

func _process(delta):
	if linear_velocity.length() < 1:
		var explo = load("res://Fireworks/Explotion.tscn").instance()
		explo.translation = self.translation
		get_parent().add_child(explo)
		queue_free()

