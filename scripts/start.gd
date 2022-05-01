extends Button


var plus = false
var blink = true




func _physics_process(_delta):
	if blink:
		get_parent().modulate.a += 0.03
	if get_parent().modulate.a > 1:
		get_parent().modulate.a = 1
		blink = false
	
	if plus == false:
		modulate.a -= 0.013
	if modulate.a <= 0.13:
		
		plus = true
	if plus:
		modulate.a += 0.013
		if modulate.a > 0.9:
			plus = false
	if Globalvariables.start == true:
		get_tree().paused = false
		get_parent().get_node("Time").visible = true
		get_parent().get_node("score").visible = true
		get_parent().get_node("shop").visible = false
		queue_free()

func _on_start_pressed():
	Globalvariables.start = true




