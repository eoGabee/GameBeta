extends CharacterBody2D
class_name MainCharacter

@onready var COMBATREF = $HitBox

var direction = dir()

#################################################################################
##                                MOVIMENTAÇÃO                                 ##
#################################################################################

# Retorna o vetor de direção baseado nos inputs
func dir() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

# Lógica principal de movimento
func move():
	if COMBATREF.states == COMBATREF.StateMachine.IDLE:
		handle_movement_input()
		dash()

# Aplica um impulso extra na direção atual se LMB for pressionado
func dash():
	if velocity != Vector2.ZERO:
		if Playerstats.folego >= Playerstats.perda_folego_dash:
			if velocity != Vector2.ZERO and Input.is_action_just_pressed("dash"):
				velocity += direction * Playerstats.dash_force
				Playerstats.folego -= Playerstats.perda_folego_dash

func handle_movement_input():
	if direction != Vector2.ZERO: #verificação de vetor#
		var speed = Playerstats.velocidade #velocidade padrao#
		if Input.is_action_pressed("run") and Playerstats.folego >= Playerstats.perda_folego_corrida: #checagem de ação#
			speed = Playerstats.velocidade_correndo #velocidade correndo#
		velocity = lerp(velocity, direction * speed, 0.1) #aplica movimento#
	else:
		velocity = lerp(velocity, Vector2.ZERO, 0.1) #reduz movimento#

# Atualiza a cada frame
func _physics_process(_delta: float) -> void:
	direction = dir()
	move()
	move_and_slide()

func _on_run_taxa_timeout() -> void:
	if velocity != Vector2.ZERO and Input.is_action_pressed("run") and Playerstats.folego >= Playerstats.perda_folego_corrida:
		Playerstats.folego -= Playerstats.perda_folego_corrida
