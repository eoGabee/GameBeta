extends Area2D

func _on_range_mouse_entered() -> void:
	Build.can_build = true
func _on_range_mouse_exited() -> void:
	Build.can_build = false
