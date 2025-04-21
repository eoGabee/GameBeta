extends CharacterBody2D
class_name MainCharacter

@onready var COMBATREF = $HitBox
@onready var timer_tempo_invencivel = $tempo_invencivel

@onready var colonia = preload("res://_gameobj/builds/fogueira.tscn")

var direction = dir()

#################################################################################
##                                MOVIMENTAÇÃO                                 ##
#################################################################################

# Retorna o vetor de direção baseado nos inputs
func dir() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

# Lógica principal de movimento
func move():
	if not Playerstats.pode_levar_dano:
		$anim.play("dash")
		return
	$anim.play("Idle")
	if COMBATREF.states == COMBATREF.StateMachine.IDLE:
		handle_movement_input()
		dash()

# Aplica um impulso extra na direção atual se LMB for pressionado
func dash():
	
	if velocity.length() > 20:
		if Playerstats.folego >= Playerstats.perda_folego_dash:
			if velocity != Vector2.ZERO and Input.is_action_just_pressed("dash"):
				Playerstats.pode_levar_dano = false
				velocity += direction * Playerstats.dash_force
				Playerstats.folego -= Playerstats.perda_folego_dash
				$anim.play("dash")
				timer_tempo_invencivel.start()

func handle_movement_input():
	if direction != Vector2.ZERO: #verificação de vetor#
		var speed = Playerstats.velocidade #velocidade padrao#
		if Input.is_action_pressed("run") and Playerstats.folego >= Playerstats.perda_folego_corrida: #checagem de ação#
			speed = Playerstats.velocidade_correndo #velocidade correndo#
		velocity = lerp(velocity, direction * speed, 0.1) #aplica movimento#
	else:
		velocity = lerp(velocity, Vector2.ZERO, 0.1) #reduz movimento#

func anim_control():
	if dir().x > 0:
		$texture.flip_h = false
	if dir().x < 0:
		$texture.flip_h = true

# Atualiza a cada frame
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("1"):
		fundar_colonia_()
		
	direction = dir()
	move()
	move_and_slide()

func _process(delta: float) -> void:
	Playerstats.vidaGG()
	anim_control()
	fundar_colonia_()

func fundar_colonia_():
	if Playerstats.pode_fundar_colonia and Input.is_action_just_pressed("1"):
		var instance = colonia.instantiate()
		get_parent().add_child(instance)
		instance.global_position = global_position
		print(instance)

func _on_run_taxa_timeout() -> void:
	if velocity != Vector2.ZERO and Input.is_action_pressed("run") and Playerstats.folego >= Playerstats.perda_folego_corrida:
		Playerstats.folego -= Playerstats.perda_folego_corrida

func _on_tempo_invencivel_timeout() -> void:
	Playerstats.pode_levar_dano = true
