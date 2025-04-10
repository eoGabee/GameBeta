extends Node2D

@onready var fogueira = preload("res://_gameobj/builds/fogueira.tscn")
@onready var centro = preload("res://_gameobj/builds/centro.tscn")
@onready var casa = preload("res://_gameobj/builds/casa.tscn")


enum builds {
	OFF,
	FOGUEIRA,
	CASA,
	CENTRO,
	BANCO
}
var selected:builds = builds.FOGUEIRA
var can_b

func can_build(mp):
	var estruturas = get_tree().get_nodes_in_group("colonia")
	var estrutura_proxima = null
	var menor_dist = INF  # Define a menor distância inicial como infinito

	for i in estruturas:
		var distancia = (i.global_position - mp).length()  # Calcula a distância real
		if distancia < 150 and distancia < menor_dist:
			menor_dist = distancia
			estrutura_proxima = i  # Guarda o objeto mais próximo encontrado

	return estrutura_proxima  # Retorna a estrutura mais próxima dentro do limite


func _process(delta: float) -> void:
	can_b = can_build(get_global_mouse_position())
	match selected:
		builds.OFF:
			pass
		builds.FOGUEIRA:
			if Playerstats.madeira > 10 and Input.is_action_just_pressed("RMB"):
					add_build(fogueira)
					Playerstats.madeira -= 10
		builds.CENTRO:
			if can_b:
				add_build(centro)
		builds.CASA:
			if can_b:
				add_build(casa)
		builds.BANCO:
			if can_b:
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
		instance.add_to_group("estruturas")  # Garante que a nova estrutura será verificada
		selected = builds.OFF
		
