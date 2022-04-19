extends Node2D

var blink = true

var values = Globalvariables.savegame_data
func _ready():
	modulate.a = 0
func _physics_process(delta):
	if blink:
		modulate.a += 0.05
		print(modulate.a)
	if modulate.a > 1:
		modulate.a = 1
		blink = false

func _on_TextureButton_button_down():
	get_tree().change_scene("res://scenes/screen.tscn")


func _on_nextpage_button_down():
	get_tree().change_scene("res://scenes/shop2.tscn")


func _on_backpage_button_down():
	get_tree().change_scene("res://scenes/shop.tscn")


func _on_exit2_button_down():
	get_tree().change_scene("res://scenes/screen.tscn")











func _on_damage_pressed():
	if $damage.pressed:
		$damage.texture_normal = load("res://assets/image/more info background.png")
		$damagetext.visible = true
		$damagetext.set_text("Increase the \ndamage of your \nbullets\n\nCurrent Level: "+ str(values.damagelvl)+ "\nPrice: " + str(6*(values.damagelvl * values.damagelvl)) + " Coins")
	else:
		$damage.texture_normal = load("res://assets/image/shopdamage.png")
		$damagetext.visible = false
		

func _on_starthp_pressed():
	if $starthp.pressed:
		$starthp.texture_normal = load("res://assets/image/more info background.png")
	else:
		$starthp.texture_normal = load("res://assets/image/bumperstarthp.png")

func _on_hpmultiply_pressed():
	if $hpmultiply.pressed:
		$hpmultiply.texture_normal = load("res://assets/image/more info background.png")
	else:
		$hpmultiply.texture_normal = load("res://assets/image/hpmultiply.png")

func _on_shootdelay_pressed():
	if $shootdelay.pressed:
		$shootdelay.texture_normal = load("res://assets/image/more info background.png")
	else:
		$shootdelay.texture_normal = load("res://assets/image/shopdamage.png")


func _on_lessloss_pressed():
	if $lessloss.pressed:
		$lessloss.texture_normal = load("res://assets/image/more info background.png")
	else:
		$lessloss.texture_normal = load("res://assets/image/shopdamage.png")


func _on_moretime_pressed():
	if $moretime.pressed:
		$moretime.texture_normal = load("res://assets/image/more info background.png")
	else:
		$moretime.texture_normal = load("res://assets/image/shopdamage.png")
