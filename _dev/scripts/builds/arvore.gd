extends RecursosBase

func _ready() -> void:
	add_drop("madeira")
	add_drop("pedra")

func _process(delta: float) -> void:
	life_gerency()
	
