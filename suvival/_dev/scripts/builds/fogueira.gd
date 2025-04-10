extends Area2D
class_name Colonia

@export var colonia_max:int = 4
@export var colonia_moradores:int = 0

@export var colonia_moradores_obj:Array
@export var casas_colonia:Array
@export var centro:Array

var colonia_posicao

func _process(delta: float) -> void:
	if not colonia_moradores_obj.is_empty():
		for i in colonia_moradores_obj:
			if not casas_colonia.is_empty():
				i.casa = casas_colonia.pick_random()
			if not centro.is_empty():
				i.centro = centro.pick_random()
			if not i.colonia:
				i.colonia = self

func _ready() -> void:
	colonia_posicao = global_position
