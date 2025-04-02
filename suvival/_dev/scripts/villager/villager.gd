extends CharacterBody2D
class_name Villager

var can_do_anything:bool = false
var speed = 50

var casa
var colonia

var arr = []

signal come_back

var patrol:bool = true

func _ready() -> void:
	casa = get_tree().get_first_node_in_group("casa")

func _process(delta: float) -> void:
	
	var s = get_tree().get_first_node_in_group("casa")
	if s:
		casa = s
	
	if casa:
		arr.append(casa)
	if colonia:
		arr.append(colonia)
	
	if not colonia:
		patrol = true
	
	if not patrol:
		move_towards_casa(delta, arr.pick_random())
	else:
		move_and_slide()

func move_towards_casa(delta: float, dir) -> void:
	# Mover o villager suavemente em direção à casa
	var direction = dir.position - position
	# Use 'normalized()' para garantir que o movimento tenha a mesma velocidade independentemente da distância
	if direction.length() > 5:  # Defina um limite de proximidade para parar o movimento
		velocity = direction.normalized() * speed
		move_and_slide()  # Mover o personagem suavemente
	else:
		# Chegou ao destino, parar de mover
		velocity = Vector2()

func _on_walktimer_timeout() -> void:
	if patrol:
		velocity = lerp(velocity, Vector2(randi_range(-10, 10), randi_range(-10,10)) * speed, 0.1)
func _on_walktimer_2_timeout() -> void:
	if patrol:
		velocity = Vector2()
func _on_come_back() -> void:
	patrol = false
	
func _on_vision_area_entered(area: Area2D) -> void:
	if area.is_in_group("colonia"):
		colonia = area


func _on_rotine_timeout() -> void:
	patrol = not patrol
