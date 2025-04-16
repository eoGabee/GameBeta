extends Area2D
class_name RecursosBase

@export var vida:int = 100
@export var recurso_obj:String

@onready var item = preload("res://_gameobj/item.tscn")

@export var droplist:Array = []

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("recurso"):
		vida -= 50

func _process(delta: float) -> void:
	life_gerency()

func add_drop(item:String):
	droplist.append(item)

func life_gerency():#AND DROP#
	if vida <= 0:
		CameraShake.shake(0.5, 2)
		for i in randi_range(1, 5):
			var x = item.instantiate()
			get_parent().add_child(x)
			x.global_position = global_position
			if not droplist.is_empty():
				x.item = droplist.pick_random()
			else:
				push_error("SEM ITEM DEFINIDO PARA DROP")
		queue_free()
	pass
