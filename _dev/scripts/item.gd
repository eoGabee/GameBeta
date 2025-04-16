extends Node
class_name Item

@export var item:String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		match item:
			"madeira":
				Playerstats.madeira += 1
			"pedra":
				Playerstats.pedra += 1
		queue_free()
