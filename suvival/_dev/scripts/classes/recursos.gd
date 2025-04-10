extends Area2D
class_name Recursos

@onready var item:=preload("res://_gameobj/item.tscn")

var quebravel:bool = false
var saude:float = 100

func quebrar(item:String):
	if quebravel and Input.is_action_just_pressed("RMB"):
		saude -= 20
		CameraShake.shake(0.2, 8.0)
	
	if saude <= 0:
		dropar_item(item)
		await 10
		queue_free()

func dropar_item(item_):
	for i in randi_range(1, 4):
		var instance = item.instantiate()
		get_parent().add_child(instance)
		instance.position = global_position
		instance.item = item_

func _mouse_enter() -> void:
	quebravel = true
func _mouse_exit() -> void:
	quebravel = false
