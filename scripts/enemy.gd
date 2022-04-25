extends KinematicBody2D

var jump = -900
var gravity = 450
var motion = Vector2(300, 400)
var starthp
var hp = 0
var damage = 0



func _ready():
	var colors = ["res://assets/image/enemyblue.png","res://assets/image/enemyred.png", "res://assets/image/enemyyellow.png"]
	$Sprite.texture = load(colors[randi() % 3])
	
	var extra_hp = randi() % (int(Globalvariables.level) * int(Globalvariables.level))
	hp = int((0.5*(Globalvariables.level * Globalvariables.level) + 0.5* extra_hp)+1)
	
	
	damage = int(hp / 10) + hp
	hp *= 1000
	starthp = hp
	$Label.set_text(Globalvariables.enemyvalue(hp))



func _physics_process(delta):
	
	
	#dead
	if position.y > 1134:
		Globalvariables.BumperHp = 5
		Globalvariables.level = Globalvariables.savegame_data.startlevel - 1
		Globalvariables.save_data()
		Globalvariables.start = false
		
		get_tree().reload_current_scene()
		
	motion.y += gravity * delta
	move_and_slide(motion, Vector2.UP)
	if is_on_wall():
		motion.x = -motion.x








func _on_DeadTimer_timeout():
	modulate.a -= 0.3
	print(modulate.a)
	if modulate.a <= -1:
		get_tree().reload_current_scene()
