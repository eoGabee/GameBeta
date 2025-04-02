extends Area2D
class_name Casa

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("villager"):
		body.visible = false
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("villager"):
		body.visible = true
