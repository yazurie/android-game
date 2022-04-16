extends Node2D

var works = true
var top = 50
var down = 850
var move = false
var active = true

var target
var targpos
var moving
signal won


func _physics_process(_delta):
	active = get_parent().Game1
	moving = get_parent().moving
	works = position.y <= 50
	if move == true:
		target.position = lerp(target.position, Vector2(250, 850), 0.2)
		
		if target.position.y > 849.4:
			
			move = false
			get_parent().moving = true
			
			
			
	


func _on_buttontexture_pressed():
	if works and not move and active:
		var color = get_node("buttontexture").texture_normal
		var correct = get_parent().colorM
		if color == correct:
			
			emit_signal("won")
		else:
			get_tree().reload_current_scene()
 



func _on_Button_won():
	print("yeet")
	for i in get_parent().get_children():
		if i.position.y > top or i.get_node("buttontexture").texture_normal != get_parent().colorM:
			i.queue_free()
		else:
			target = i
			get_parent().Score += 1
			get_parent().emit_signal("score_changed")
			get_parent().changecolor = target
			get_parent().dochange = true
			move = true
	
	
	get_parent().emit_signal("respawn")
