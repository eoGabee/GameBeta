extends Area2D
class_name Recursos

@export var saude: float = 100.0
@export var tipo: String = "madeira"
@export var quem_vai_quebrar: Node2D = null
@onready var item = preload("res://_gameobj/item.tscn") # Substitua pelo seu item

func _ready():
	pedir_coleta()

func pedir_coleta():
	var colonias = get_tree().get_nodes_in_group("colonia")
	if colonias.size() > 0:
		colonias[0].registrar_recurso(self)

func quebrar(item_: String):
	if mouse_entered:
		saude -= 50
		if saude <= 0:
			dropar_item(item_)
			queue_free()
func dropar_item(item_: String):
	var quantidade = randi_range(1, 3)
	for i in quantidade:
		var instancia = item.instantiate()
		get_parent().add_child(instancia)
		instancia.position = global_position
		instancia.item = item_
