extends Spatial

onready var rocket = load("res://Fireworks/Rocket.tscn")
export var wait = 0

func _ready():
	yield(get_tree().create_timer(wait), "timeout")
	$Timer.start()

func _on_Timer_timeout():
	var i = rocket.instance()
	i.translation = self.translation
	get_parent().add_child(i)
