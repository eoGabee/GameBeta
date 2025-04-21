extends Node2D
class_name ItemInv

func _init(nome, quantidade) -> void:
	var i = Item_Template
	i.d

@export var Item_Template:Dictionary = {
	"nome":"nome",
	"quantidade":"quantidade"
}
