extends Spatial

var warp = true

func _input(ev):
	if ev.is_action_pressed('ui_toggleFullscreen'):
		OS.window_fullscreen = !OS.window_fullscreen
	if ev.is_action_pressed('ui_toggleCapture'):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
