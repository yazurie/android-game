extends TouchScreenButton

var right = false

func _ready():
	visible = false


func _physics_process(_delta):
	if right:
		get_parent().get_node("screen/Bumper").motion.x = 450






func _on_rightmove_pressed():
	right = true


func _on_rightmove_released():
	right = false
