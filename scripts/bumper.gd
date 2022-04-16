extends KinematicBody2D

var spawn = true
var Hp = 0
var timerstarted = false
var spawnstarted = true
var motion = Vector2()
var totalscore = 0

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
			get_parent().get_parent().get_node("score").visible = false
			if spawnstarted == true:
				spawnstarted = false
				$spawnbutton.start()
	
	if not spawn:
		if get_parent().Score != 0 and not timerstarted:
			totalscore = get_parent().Score
			$Label/HpUp.start()
			timerstarted = true



func _on_HpUp_timeout():
	if get_parent().Score > 0:
		if get_parent().Score - (1 + totalscore / 100) > 0:
			Hp += 1 + totalscore / 100
			get_parent().Score -= 1 + totalscore / 100
		else:
			Hp += get_parent().Score
			get_parent().Score = 0
		get_parent().get_parent().get_node("score").set_text(str(stepify(get_parent().Score, 1)))
		
		$Label.set_text(str(Hp))
	else:
		get_parent().get_parent().get_node("score").visible = false
		$Label/HpUp.stop()
		$spawnbutton.start()


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


func movement():
	move_and_slide(motion)
	motion = Vector2.ZERO
