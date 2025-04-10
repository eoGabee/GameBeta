extends Control

func _process(delta: float) -> void:
	$Canva/Label.text = str("MADEIRA: ", Playerstats.madeira)
	$Canva/Label2.text = str("PEDRA: ", Playerstats.pedra)
