extends Node2D

@onready var player = get_parent()
@onready var magia_slots:Array = []
signal dash
@export var states:StateMachine = StateMachine.IDLE
enum StateMachine {
	IDLE,
	BATENDO,
	MAGIA
}

func _process(delta: float) -> void:
	ataque()

func ataque():
	if states == StateMachine.IDLE:
		look_at(get_global_mouse_position())
	elif states == StateMachine.BATENDO:
		player.velocity = Vector2()
		return
	
	if Input.is_action_just_pressed("RMB") and not states == StateMachine.BATENDO:
		$HitBox/AnimationPlayer.play("attack_sword")
		CameraShake.shake(0.2, 0.5)
		if states == StateMachine.MAGIA:
			return
		states = StateMachine.BATENDO

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_sword":
		states = StateMachine.IDLE
