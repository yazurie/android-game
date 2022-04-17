extends KinematicBody2D

var spawn = true
var damage = 1
var timerstarted = false
var spawnstarted = true
var motion = Vector2()
var totalscore = 0
var hpmultiplier = 1

onready var globalvar = get_node("/root/Globalvariables")

func _ready():
	$Label.set_text(str(globalvar.BumperHp))
func _physics_process(_delta):
	
	movement()
	
	if position.x < 146:
		position.x = 146
	if position.x > 572:
		position.x = 572
	if spawn == true:
		position = lerp(position, Vector2(350, 1050), 0.05)
	
	if position.y < 1051.5:
		spawn = false
		if get_parent().Score == 0:
			if spawnstarted == true:
				spawnstarted = false
				$spawnbutton.start()
	
	if not spawn:
		if get_parent().Score != 0 and not timerstarted:
			totalscore = get_parent().Score
			globalvar.corrBumperHp = globalvar.BumperHp
			$Label/HpUp.start()
			timerstarted = true
			
			get_parent().get_parent().get_node("click").set_stream(load("res://assets/sounds/counter.ogg"))
			get_parent().get_parent().get_node("click").pitch_scale = 1.5
	



func _on_HpUp_timeout():
	
	if get_parent().Score > 0:
		get_parent().get_parent().get_node("click").play()
		if get_parent().Score - (1 + totalscore / 100) > 0:
			globalvar.BumperHp +=  hpmultiplier * (1 +  totalscore / 100)
			get_parent().Score -= 1 + totalscore / 100
		else:
			globalvar.BumperHp += get_parent().Score * 10
			get_parent().Score = 0
			get_parent().get_parent().get_node("score").visible = false
		
		
	if  totalscore < 0:
		if get_parent().Score < 0 and globalvar.BumperHp > 0:
			get_parent().get_parent().get_node("click").pitch_scale = 0.4
			get_parent().get_parent().get_node("click").play()
		if get_parent().Score - (1 + totalscore / 100) < 0 and globalvar.BumperHp > 0:
			globalvar.BumperHp -=  hpmultiplier * (1 +  totalscore / 100)
			get_parent().Score += 1 + totalscore / 100
		
		else:
			get_parent().Score = 0
			globalvar.BumperHp = 1
	$Label.set_text(str(globalvar.BumperHp))
	print(get_parent().Score - (1 + totalscore / 100) )
	
	if get_parent().Score == 0:
		globalvar.BumperHp = globalvar.corrBumperHp + totalscore
		if globalvar.BumperHp < 0:
			globalvar.BumperHp = 1
		
		
		$Label.set_text(str(globalvar.BumperHp))
		#get_parent().get_parent().get_node("click").queue_free()
		#get_parent().get_parent().get_node("score").queue_free()
		$Label/HpUp.stop()
		$spawnbutton.start()
	get_parent().get_parent().get_node("score").set_text(str(get_parent().Score))


func _on_spawnbutton_timeout():
	print("ok")
	var leftb = load("res://scenes/leftarr.tscn")
	var rightarr = load("res://scenes/rightarr.tscn")
	var leftinst = leftb.instance()
	var rightinst = rightarr.instance()
	leftinst.position = Vector2(80, 760)
	rightinst.position = Vector2(570, 760)
	get_parent().add_child(leftinst)
	get_parent().add_child(rightinst)
	$spawnbutton.stop()
	print(get_parent().get_children())
	$shootdelay.start()
	spawnenemy()
	


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
	globalvar.BumperHp -= body.damage
	if globalvar.BumperHp < 1:
		get_tree().reload_current_scene()
	$Label.set_text(str(globalvar.BumperHp))
	

func spawnenemy():
	var enemy = load("res://scenes/enemy.tscn").instance()
	enemy.position = Vector2(165,100)
	get_parent().add_child(enemy)
