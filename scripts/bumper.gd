extends KinematicBody2D

var spawn = true

var timerstarted = false
var spawnstarted = true
var motion = Vector2()
var totalscore = 0
var hpmultiplier = 1




func _ready():
	$shootdelay.wait_time = 0.7 - (float(Globalvariables.savegame_data.shootdelaylvl) / 10)
	if Globalvariables.BumperHp < 0.25*(Globalvariables.savegame_data.startBumpHpLvl*Globalvariables.savegame_data.startBumpHpLvl):
		
		Globalvariables.BumperHp = 0.25*(Globalvariables.savegame_data.startBumpHpLvl*Globalvariables.savegame_data.startBumpHpLvl)
	$Label.set_text(Globalvariables.Bumpervalue(Globalvariables.BumperHp))
func _physics_process(_delta):
	
	movement()
	
	if position.x < 146:
		position.x = 146
	if position.x > 572:
		position.x = 572
	if spawn == true:
		position = lerp(position, Vector2(position.x, 1050), 0.05)
	
	if position.y < 1051.5:
		spawn = false
		if get_parent().Score == 0:
			if spawnstarted == true:
				spawnstarted = false
				$spawnbutton.start()
	
	if not spawn:
		if get_parent().Score != 0 and not timerstarted:
			totalscore = get_parent().Score
			Globalvariables.corrBumperHp = Globalvariables.BumperHp
			$Label/HpUp.start()
			timerstarted = true
			
			get_parent().get_parent().get_node("click").set_stream(load("res://assets/sounds/counter.ogg"))
			get_parent().get_parent().get_node("click").pitch_scale = 1.24
			get_parent().get_parent().get_node("click").volume_db = -20
		if get_parent().Score == 0 and not timerstarted:
			get_parent().get_parent().get_node("score").queue_free()
			timerstarted = true



func _on_HpUp_timeout():
	if get_parent().Score > 0:
		get_parent().get_parent().get_node("click").play()
		if get_parent().Score - (1 + totalscore / 100) > 0:
			Globalvariables.BumperHp +=  hpmultiplier * (1 +  totalscore / 100)
			get_parent().Score -= 1 + totalscore / 100
		else:
			Globalvariables.BumperHp += get_parent().Score * 10
			get_parent().Score = 0
			
		
		
	if  get_parent().Score < 0:
		get_parent().get_parent().get_node("click").pitch_scale = 0.4
		get_parent().get_parent().get_node("click").play()
		if get_parent().Score + (1 + abs(totalscore) / 100) < 0:
			Globalvariables.BumperHp -= hpmultiplier * (1 + abs(totalscore) /100)
			get_parent().Score += 1 + abs(totalscore) / 100
		else:
			Globalvariables.BumperHp -= get_parent().Score * 10
			get_parent().Score = 0
		if Globalvariables.BumperHp <= 0:
			Globalvariables.start = false
			Globalvariables.level = Globalvariables.savegame_data.startlevel - 1
			get_tree().reload_current_scene()
	$Label.set_text(Globalvariables.Bumpervalue(Globalvariables.BumperHp))
	get_parent().get_parent().get_node("score").set_text(str(round(get_parent().Score)))
	
	if get_parent().Score == 0:
		Globalvariables.BumperHp = Globalvariables.corrBumperHp + totalscore
		
		
		
		$Label.set_text(Globalvariables.Bumpervalue(Globalvariables.BumperHp))
		
		get_parent().get_parent().get_node("score").queue_free()
		$Label/HpUp.stop()
		$spawnbutton.start()
		
	


func _on_spawnbutton_timeout():
	$spawnbutton.stop()
	$shootdelay.start()
	spawnenemy()
	get_parent().get_parent().get_node("click").queue_free()
	


func movement():
	move_and_slide(motion)
	motion = Vector2.ZERO


func _on_shootdelay_timeout():
	var bullet = load("res://scenes/bullet.tscn")
	var bullet_instance = bullet.instance()
	bullet_instance.position.x = position.x
	bullet_instance.position.y = 1050
	get_parent().add_child(bullet_instance)


func _on_Area2D_body_entered(body):
	
	body.motion.y = body.jump
	Globalvariables.BumperHp -= body.damage
	Globalvariables.BumperHp = round(Globalvariables.BumperHp)
	if Globalvariables.BumperHp < 1:
		Globalvariables.level = Globalvariables.savegame_data.startlevel - 1
		Globalvariables.start = false
		get_tree().reload_current_scene()
	$Label.set_text(Globalvariables.Bumpervalue(Globalvariables.BumperHp))
	

func spawnenemy():
	
	var enemy = load("res://scenes/enemy.tscn").instance()
	enemy.position = Vector2(randi() % 350 + 150,randi() % 450)
	enemy.motion.x = randi() % 400 + 300
	enemy.jump = -100*(randi() % 4) + -800
	enemy.gravity = -enemy.jump / 1.5
	if randi() % 2 == 1:
		enemy.motion.y = -enemy.motion.y
	get_parent().add_child(enemy)

