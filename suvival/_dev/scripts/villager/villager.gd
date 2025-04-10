extends entity
class_name villager

var temcolonia: bool = false
var seguindo_ordem: bool = false
var waiting: bool = false
var patrol_area: Rect2
var target_point: Vector2

@export var centro: Vector2
@export var casa: Vector2
@export var colonia: Area2D

@export var stop_distance: float = 10.0
@export var wait_time: float = 3.0

func _ready() -> void:
	if temcolonia and colonia:
		definir_area_de_patrulha()
		choose_new_target()

func _process(delta: float) -> void:
	if not temcolonia:
		achar_colonia()
	elif not seguindo_ordem:
		patrulha()

func achar_colonia():
	var colonias = get_tree().get_nodes_in_group("colonia")
	for i in colonias:
		if i.colonia_moradores < i.colonia_max:
			i.colonia_moradores_obj.append(self)
			colonia = i
			temcolonia = true
			definir_area_de_patrulha()
			choose_new_target()
			break

func definir_area_de_patrulha():
	if colonia == null:
		push_error("Colônia não está definida!")
		return

	var collision_shape = colonia.get_node_or_null("col")
	if collision_shape == null or collision_shape.shape == null:
		push_error("⚠️ CollisionShape2D 'col' está ausente ou sem shape.")
		return

	var shape = collision_shape.shape

	var area_center = collision_shape.global_position
	var size: Vector2

	if shape is RectangleShape2D:
		size = shape.size
	elif shape is CircleShape2D:
		var r = shape.radius
		size = Vector2(r * 2, r * 2)
	else:
		push_error("⚠️ Tipo de shape não suportado: " + str(shape))
		return

	var top_left = area_center - (size / 2)
	patrol_area = Rect2(top_left, size)



func patrulha():
	if waiting:
		return

	var direction = (target_point - global_position).normalized()
	var distance = global_position.distance_to(target_point)

	if distance > stop_distance:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
		waiting = true
		await get_tree().create_timer(wait_time).timeout
		choose_new_target()
		waiting = false

	move_and_slide()

func choose_new_target():
	var x = randf_range(patrol_area.position.x, patrol_area.position.x + patrol_area.size.x)
	var y = randf_range(patrol_area.position.y, patrol_area.position.y + patrol_area.size.y)
	target_point = Vector2(x, y)
