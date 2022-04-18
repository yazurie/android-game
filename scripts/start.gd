extends Button


var plus = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(_delta):
	
	
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
		queue_free()

func _on_start_pressed():
	Globalvariables.start = true
