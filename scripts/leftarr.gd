extends TouchScreenButton


var left = false







func _physics_process(_delta):
	if left:
		get_parent().get_node("Bumper").motion.x = -300


func _on_TouchScreenButton_pressed():
	left = true


func _on_TouchScreenButton_released():
	left = false
