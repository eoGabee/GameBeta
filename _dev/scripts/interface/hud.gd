extends Control

var menu_inv:bool = false

func _process(_delta: float) -> void:
	$Canva/Label.text = str("MADEIRA: ", Playerstats.madeira)
	$Canva/Label2.text = str("PEDRA: ", Playerstats.pedra)
	$Canva/Label4.text = str("FOLEGO: ", Playerstats.folego)
	
	
	if Input.is_action_just_pressed("esc"):
		menu_inv = not menu_inv
