extends Node

# Referência à câmera que será afetada
var camera: Camera2D = null

# Tempo restante do efeito de tremor
var shake_time_left: float = 0.0

# Intensidade do tremor
var shake_intensity: float = 0.0

# Offset original da câmera (para restaurar depois do shake)
var original_offset: Vector2 = Vector2.ZERO

func _process(delta):
	if camera == null:
		return  # Sem câmera registrada, não faz nada

	if shake_time_left > 0:
		# Reduz o tempo restante do efeito
		shake_time_left -= delta

		# Aplica um offset aleatório à câmera com base na intensidade
		camera.offset = original_offset + Vector2(
			randf_range(-1, 1),
			randf_range(-1, 1)
		) * shake_intensity
	else:
		# Volta o offset ao original quando o efeito termina
		camera.offset = original_offset

# Registra a câmera que será afetada pelo tremor
func register_camera(cam: Camera2D):
	camera = cam
	original_offset = cam.offset  # Salva o offset atual da câmera

# Inicia o efeito de tremor
func shake(duration: float = 0.3, intensity: float = 10.0):
	if camera == null:
		push_warning("Camera não registrada no CameraShake.")
		return

	shake_time_left = duration
	shake_intensity = intensity
