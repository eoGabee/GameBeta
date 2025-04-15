extends Control

@onready var slot = preload("res://_gameobj/HUD/slotcraft.tscn")


#fogueira############################
const fogueira_cost_madeira:int = 10#
const fogueira_cost_pedra:int = 5   #
#####################################

var fogueira = {
	"nome":"fogueira",
	"custo":str("MADEIRA", fogueira_cost_madeira, "PEDRA",fogueira_cost_pedra)
}

var can_craft:Array = []

func checagem():
	if Playerstats.madeira >= fogueira_cost_madeira and Playerstats.pedra >= fogueira_cost_pedra:
		can_craft.append(fogueira)
	
