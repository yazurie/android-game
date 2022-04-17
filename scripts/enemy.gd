extends KinematicBody2D

var jump = -900
var gravity = 450
var motion = Vector2(300, 400)
var hp = 0
var damage = 0

func _ready():
	damage = randi() % 3 + 1
	hp = damage * 3
	$Label.set_text(str(hp))



func _physics_process(delta):
	print(hp)
	if position.y > 1070:
		#motion.y = jump
		modulate.r = 232
		modulate.g = 1
		modulate.b = 1
	if position.y > 1134:
		get_tree().reload_current_scene()
		queue_free()
	motion.y += gravity * delta
	move_and_slide(motion, Vector2.UP)
	if is_on_floor():
		motion.y = jump
	if is_on_wall():
		motion.x = -motion.x




