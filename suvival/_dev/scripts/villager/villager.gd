extends CharacterBody2D
class_name Villager

@export var speed: float = 100.0
@export var stop_distance: float = 10.0
@export var wait_time: float = 2.0

var seguindo_ordem := false
var waiting := false
var alvo_atual: Node2D = null
var colonia: Node = null

func _ready():
	add_to_group("villager")
	achar_colonia()

func _process(delta):
	if seguindo_ordem:
		coletar()
	else:
		# Idle ou patrulha aqui se quiser
		pass

func coletar():
	if alvo_atual == null:
		seguindo_ordem = false
		return

	var direction = (alvo_atual.global_position - global_position).normalized()
	var distance = global_position.distance_to(alvo_atual.global_position)

	if distance > stop_distance:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
		waiting = true
		await get_tree().create_timer(wait_time).timeout

		if alvo_atual and alvo_atual.has_method("quebrar"):
			alvo_atual.quebrar("madeira")  # troca conforme tipo de recurso

		alvo_atual = null
		seguindo_ordem = false
		waiting = false

	move_and_slide()

func receber_ordem(recurso: Node2D):
	alvo_atual = recurso
	seguindo_ordem = true

func achar_colonia():
	var colonias = get_tree().get_nodes_in_group("colonia")
	if colonias.size() > 0:
		colonia = colonias[0]
		colonia.colonia_moradores_obj.append(self)
