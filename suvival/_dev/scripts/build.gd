extends Node2D

@onready var fogueira = preload("res://_gameobj/builds/fogueira.tscn")
@onready var centro = preload("res://_gameobj/builds/centro.tscn")
@onready var casa = preload("res://_gameobj/builds/casa.tscn")

var can_build:bool = false

enum builds {
	OFF,
	FOGUEIRA,
	CASA,
	CENTRO,
	BANCO
}
var selected:builds = builds.FOGUEIRA

func _process(delta: float) -> void:
	match selected:
		builds.OFF:
			pass
		builds.FOGUEIRA:
			if !can_build:
				add_build(fogueira)
		builds.CENTRO:
			if can_build:
				add_build(centro)
		builds.CASA:
			if can_build:
				add_build(casa)
		builds.BANCO:
			if can_build:
				pass
		
	if Input.is_action_just_pressed("1"):
		selected = builds.OFF
	elif Input.is_action_just_pressed("2"):
		selected = builds.FOGUEIRA
	elif Input.is_action_just_pressed("3"):
		selected = builds.CASA
	elif Input.is_action_just_pressed("4"):
		selected = builds.CENTRO

func add_build(b):
	if Input.is_action_just_pressed("RMB"):
		var instance = b.instantiate()
		add_child(instance)
		instance.position = get_global_mouse_position()
		selected = builds.OFF
		
