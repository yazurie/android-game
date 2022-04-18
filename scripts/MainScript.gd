extends Node2D

var timefont = DynamicFont.new()
var button = preload("res://scenes/Button.tscn")
var red = preload("res://assets/image/redB.png")
var blue = preload("res://assets/image/blueB.png")
var yellow = preload("res://assets/image/yellowB.png")
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
	
	fspawn()
	spawn(50)
	get_parent().get_node("level").set_text(str(Globalvariables.level))
	get_tree().paused = true

func fspawn():
	get_parent().get_node("coin/Label").set_text(str(Globalvariables.savegame_data.Coins))
	get_parent().get_node("Timer").start()
	var colorchoice = [red, blue, yellow]
	var spawnbutton = button.instance()
	colorM = colorchoice[randi() % 3]
	spawnbutton.position.x = 240
	spawnbutton.position.y = down
	spawnbutton.get_node("buttontexture").texture_normal = colorM
	add_child(spawnbutton)
	timefont.size = 128
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
	


func _on_screen_fspawn():
	fspawn()


