extends Camera2D

func _ready() -> void:
	CameraShake.register_camera(self)
