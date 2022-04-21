extends TouchScreenButton


var left = false

func _ready():
	visible = false





func _physics_process(_delta):
	if left:
		get_parent().get_node("screen/Bumper").motion.x = -300







func _on_leftmove_pressed():
	left = true


func _on_leftmove_released():
	left = false
