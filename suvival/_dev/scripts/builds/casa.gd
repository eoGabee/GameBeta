extends Area2D
class_name Casa

@export var tamanho:int = 0
@export var max:int = 3

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("villager"):
		body.visible = false
		tamanho += 1
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("villager"):
		tamanho -= 1
		body.visible = true
