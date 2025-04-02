extends CharacterBody2D
class_name MainCharacter

var speed:float = 200
var dash_force:float = 500

func dir():
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

func move():
	move_and_slide()
	dash()
	
	if dir():
		velocity = lerp(velocity, dir() * speed, 0.1)
	else:
		velocity = lerp(velocity, Vector2(), 0.1)

func dash():
	if velocity != Vector2() and Input.is_action_just_pressed("LMB"):
		velocity += dir() * dash_force

func _process(delta: float) -> void:
	move()
