extends KinematicBody2D


var damage

func _ready():
	damage = get_parent().get_node("Bumper").damage

func _physics_process(_delta):
	move_and_slide(Vector2(0, -1500))
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	body.hp -= 1
	body.get_node("Label").set_text(str(body.hp))
	if body.hp < 1:
		body.get_parent().Game1 = true
		body.get_parent().emit_signal("respawn")
		body.get_parent().emit_signal("fspawn")
		body.get_parent().get_parent().get_node("click").set_stream(load("res://assets/sounds/click.ogg"))
		body.get_parent().get_parent().get_node("click").pitch_scale = 2
		body.get_parent().get_node("Bumper").queue_free()
		body.get_parent().get_node("leftarr").queue_free()
		body.get_parent().get_node("rightarr").queue_free()
		#get_parent()
		body.queue_free()
	queue_free()
