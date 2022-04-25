extends KinematicBody2D


var damage = Globalvariables.savegame_data.damagelvl




func _physics_process(_delta):
	move_and_slide(Vector2(0, -1500))
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	body.hp -= round(0.25*(0.25*(damage * damage)) + damage)
	body.get_node("Label").set_text(Globalvariables.enemyvalue(body.hp))
	queue_free()
	if body.hp < 1:
		body.set_physics_process(false)
		body.hp = 0
		body.get_node("Label").set_text(str(body.hp))
		body.get_node("CollisionShape2D").queue_free()
		Globalvariables.savegame_data.Coins += (float(body.starthp) / 10) * Globalvariables.level
		Globalvariables.savegame_data.Coins = stepify(Globalvariables.savegame_data.Coins, 0.1)
		Globalvariables.save_data()
		get_parent().get_parent().get_node("coin/Label").set_text(Globalvariables.smallvalue(Globalvariables.savegame_data.Coins))
		body.get_node("DeadTimer").start()
