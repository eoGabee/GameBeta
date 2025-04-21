extends Node

var INVENTARIO:Array = []
var tamanho_do_inventario:int = 5

var empty:Dictionary = {
	"nome": "vazio",
	"quantidade": 1
}

var espada:Dictionary = {
	"nome": "espada",
	"quantidade": 1
}

func _ready() -> void:
	iniciar()

func _process(delta: float) -> void:
	#print(INVENTARIO).
	pass

func iniciar():
	if INVENTARIO.is_empty():
		for i in tamanho_do_inventario:
			INVENTARIO.append(empty.duplicate())

func adicionar_item(item: Dictionary, quantidade: int) -> void:
	for i in range(INVENTARIO.size()):
		var INV = INVENTARIO[i]
		if INV["nome"] == item["nome"]:
			INV["quantidade"] += quantidade
			INVENTARIO[i] = INV
			return
		elif INV["nome"] == "vazio":
			var novo_item = item.duplicate()
			novo_item["quantidade"] = quantidade
			INVENTARIO[i] = novo_item
			return

func limpar_inventario(nome_do_item: String, quantidade: int) -> void:
	for i in range(INVENTARIO.size()):
		var INV = INVENTARIO[i]
		if INV["nome"] == nome_do_item:
			INV["quantidade"] -= quantidade
			if INV["quantidade"] <= 0:
				INVENTARIO[i] = empty.duplicate()
			else:
				INVENTARIO[i] = INV
