extends Control

var menu_craft:bool = false

func _process(_delta: float) -> void:
	$Canva/Label.text = str("MADEIRA: ", Playerstats.madeira)
	$Canva/Label2.text = str("PEDRA: ", Playerstats.pedra)
	$Canva/Label4.text = str("FOLEGO: ", Playerstats.folego)
	
	
	if Input.is_action_just_pressed("esc"):
		menu_craft_entrar()

func menu_craft_entrar():
	menu_craft = not menu_craft
	if menu_craft == true:
		$MENU_HUD_CRAFT/AnimationPlayer.play("on")
	else:
		$MENU_HUD_CRAFT/AnimationPlayer.play("off")
	pass
