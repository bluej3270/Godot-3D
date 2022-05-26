extends KinematicBody

# physics
var moveSpeed : float = 1.0
var jumpForce : float = 1.0
var gravity : float = 4.0

# cam look
var minLookAngle : float = -90.0
var maxLookAngle : float = 90.0
var lookSensitivity : float = 10.0

var flag = load("res://Flag.tscn")
var placing_flag = true

#vectors
var vel : Vector3 = Vector3()
var mouseDelta : Vector2 = Vector2()

var respawn = Vector3(0, 4, 0)

#components
onready var camera : Camera = get_node("Camera")
onready var rocket = load("res://Fireworks/Rocket.tscn")

func _ready():
	# hide and lock the mouse cursor
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
	
func _physics_process(delta):
	# reset the x and z velocity
	vel.x = 0
	vel.z = 0
	var input = Vector2()
	
	# movement inputs
	if Input.is_action_pressed("move_forward"):
		input.y -= 1
	if Input.is_action_pressed("move_backward"):
		input.y += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
	
	input = input.normalized()
	
	# get the forward and right directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	
	var relativeDir = (forward * input.y + right * input.x)
	
	# set the velocity
	vel.x = relativeDir.x * moveSpeed
	vel.z = relativeDir.z * moveSpeed
	
	# apply gravity
	vel.y -= gravity * delta
	
	# move the player
	vel = move_and_slide(vel, Vector3.UP)
	
	# jumping
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y = jumpForce
	if $Camera/RayCast.is_colliding():
		$Camera/RayCast/Pointer.global_transform.origin = $Camera/RayCast.get_collision_point()
		$Camera/RayCast/Pointer.get_active_material(0).albedo_color = Color(0, 1, 0, 1)
	else:
		$Camera/RayCast/Pointer.translation = Vector3(0, 0, -3)
		$Camera/RayCast/Pointer.get_active_material(0).albedo_color = Color(1, 0, 0, 1)
	
#	if Input.is_action_just_released("place_flag") and $Camera/RayCast.is_colliding(): 
#		if placing_flag:
#			var instance = flag.instance()
#			instance.translation = $Camera/RayCast.get_collision_point()
#			respawn = $Camera/RayCast.get_collision_point()
#			respawn.y += 4
#			get_parent().add_child(instance)
#			placing_flag = false
#			self.translation = respawn
#		elif $Camera/RayCast.get_collider().is_in_group("Flag"):
#			var pos = $Camera/RayCast.get_collider().get_translation()
#			fireworks(pos)
#			$Camera/RayCast.get_collider().queue_free()
#			yield(get_tree().create_timer(1.5), "timeout")
#			fireworks(pos)
#			yield(get_tree().create_timer(1.5), "timeout")
#			fireworks(pos)
			
			

func _input(event):
	if event is InputEventMouseMotion:
		 mouseDelta = event.relative

func _process(delta):
	
	# rotate the camera along the x axis
	camera.rotation_degrees.x -= mouseDelta.y * lookSensitivity * delta
	
	# clamp camera x rotation axis
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
	
	# rotate the player along their y-axis
	rotation_degrees.y -= mouseDelta.x * lookSensitivity * delta
	
	# reset the mouseDelta vector
	mouseDelta = Vector2()

func fireworks(col):
	var inst = rocket.instance()
	inst.translation = col
	get_parent().add_child(inst)
	inst = 0
