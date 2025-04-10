extends Node

var camera: Camera2D = null
var shake_time_left: float = 0.0
var shake_intensity: float = 0.0
var original_offset: Vector2 = Vector2.ZERO

func _process(delta):
	if camera == null:
		return

	if shake_time_left > 0:
		shake_time_left -= delta
		camera.offset = original_offset + Vector2(
			randf_range(-1, 1),
			randf_range(-1, 1)
		) * shake_intensity
	else:
		camera.offset = original_offset

func register_camera(cam: Camera2D):
	camera = cam
	original_offset = cam.offset

func shake(duration: float = 0.3, intensity: float = 10.0):
	if camera == null:
		push_warning("Camera não registrada no CameraShake.")
		return

	shake_time_left = duration
	shake_intensity = intensity
