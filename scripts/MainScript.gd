extends Node2D

var button = preload("res://scenes/Button.tscn")
var red = preload("res://assets/image/redB.png")
var blue = preload("res://assets/image/blueB.png")
var yellow = preload("res://assets/image/yellowB.png")
var blink = true
var colorM
var top = -30000
var down = 842.5
var leftbox
var rightbox
var midbox
var moving = true
var changecolor
var dochange = false
var Score = 0
var Game1 = true



signal respawn
signal fspawn
signal score_changed

func _ready():
	Globalvariables.bonus = 1
	Globalvariables.save_data()
	
	get_parent().modulate.a = 0.1
	if Globalvariables.savegame_data.highestlevel < Globalvariables.level:
		Globalvariables.savegame_data.highestlevel = Globalvariables.level
	if Globalvariables.level < Globalvariables.savegame_data.startlevel:
		Globalvariables.level = Globalvariables.savegame_data.startlevel - 1
	
	
	if Globalvariables.time - Globalvariables.level + Globalvariables.savegame_data.timepenaltylevel > Globalvariables.savegame_data.mintime:
		if Globalvariables.time - Globalvariables.level + Globalvariables.savegame_data.timepenaltylevel < 15:
			get_parent().get_node("Timer").wait_time = Globalvariables.time - Globalvariables.level + Globalvariables.savegame_data.timepenaltylevel
		else:
			get_parent().get_node("Timer").wait_time =  15
	else:
		get_parent().get_node("Timer").wait_time = Globalvariables.savegame_data.mintime
	
	
	
	Globalvariables.level += 1
	
	
	fspawn()
	spawn(50)
	get_parent().get_node("level").set_text(str(Globalvariables.level))
	get_tree().paused = true

func fspawn():
	get_parent().get_node("coin/Label").set_text(Globalvariables.smallvalue(Globalvariables.savegame_data.Coins))
	get_parent().get_node("Timer").start()
	
	
	var colorchoice = [red, blue, yellow]
	var spawnbutton = button.instance()
	colorM = colorchoice[randi() % 3]
	spawnbutton.position.x = 240
	spawnbutton.position.y = down
	spawnbutton.get_node("buttontexture").texture_normal = colorM
	add_child(spawnbutton)
	
func spawn(spawnposy):
	
	var colorchoice = [red, blue, yellow]
	var spawnbutton = button.instance()
	
	#Top column
	var positionx = [0, 240, 480]
	for _i in range(3):
		spawnbutton = button.instance()
		var color = colorchoice[randi() % colorchoice.size()]
		spawnbutton.get_node("buttontexture").texture_normal = color
		colorchoice.erase(color)
		var posx = positionx[randi() % positionx.size()]
		spawnbutton.position.x = posx
		positionx.erase(posx)
		spawnbutton.position.y = spawnposy
		add_child(spawnbutton)
	for i in get_children():
		if i.position.y < 300:
			if i.position.x == 0:
				
				leftbox = i
			if i.position.x == 240:
				
				midbox = i	
			if i.position.x  == 480:
				rightbox = i
	

func _physics_process(_delta):
	if blink:
		if Globalvariables.start == false:
			get_parent().modulate.a += 0.04
			if get_parent().modulate.a > 1:
				get_parent().modulate.a = 1
				blink = false
		else:
			get_parent().modulate.a = 1
	#print(Engine.get_frames_per_second())
	if moving == true and Game1:
		if leftbox.position.y != 50:
			leftbox.position = lerp(leftbox.position, Vector2(0, 50), 0.4)
		if midbox.position.y != 50:
			midbox.position = lerp(midbox.position, Vector2(240, 50), 0.4)
		if rightbox.position.y != 50:
			rightbox.position = lerp(rightbox.position, Vector2(480, 50), 0.4)
		if rightbox.position.y > 40:
			if changecolor != null and dochange == true:
				
				
				var colorc = [red, blue, yellow]
				var colorcc = colorc[randi() % 3]
				changecolor.get_node("buttontexture").texture_normal = colorcc
				colorM = colorcc
				dochange = false
	if Game1:
		var time = get_parent().get_node("Timer").time_left
		get_parent().get_node("Time").set_text(str(stepify(time, 0.1)))
	


func _unhandled_input(_event):
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
func _on_screen_respawn():
	spawn(-30000)

func _on_Timer_timeout():              #ENDS PHASE 1
	get_parent().get_node("Time").queue_free()
	get_parent().get_node("Timer").queue_free()
	Game1 = false
	
	for i in get_children():
		i.queue_free()
	
	
	
	var bump = load("res://scenes/bumper.tscn")
	var bump_instance = bump.instance()
	bump_instance.position = Vector2(350, 1350)
	add_child(bump_instance)
	get_parent().get_node("leftmove").visible = true
	get_parent().get_node("rightmove").visible = true


func _on_screen_fspawn():
	fspawn()





