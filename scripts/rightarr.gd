extends TouchScreenButton

var right = false




func _physics_process(_delta):
	if right:
		get_parent().get_node("Bumper").motion.x = 300




func _on_TouchScreenButton_pressed():
	right = true


func _on_TouchScreenButton_released():
	right = false
