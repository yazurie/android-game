extends Node2D

var blink = true


var values = Globalvariables.savegame_data

func _ready():
	modulate.a = 0
	$Coins/Label.set_text(str(values.Coins))
	get_node("Coins/Label").set_text(str(Globalvariables.smallvalue(values.Coins)))



func _on_shopframe_ready():                               #affordable check in shop 1
	checkaffordable1()


func _physics_process(_delta):
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

#-----------------------------------------------------------------

#check if you got enough money to buy in shop 1


#-----------------------------------------------------------------
func checkaffordable1():
	if values.Coins >= 5*(values.damagelvl * values.damagelvl):
		$damage/buydamage.texture_normal = load("res://assets/image/enoughmoney.png")
	else:
		$damage/buydamage.texture_normal = load("res://assets/image/buydamage.png")
	if values.Coins >= 5*(values.startBumpHpLvl * values.startBumpHpLvl):
		$starthp/buystarthp.texture_normal = load("res://assets/image/enoughmoney.png")
	else:
		$starthp/buystarthp.texture_normal = load("res://assets/image/buydamage.png")
	if values.Coins >= (100*values.hplevel + (100*(values.hplevel * values.hplevel))):
		$hpmultiply/buyhpmultiply.texture_normal = load("res://assets/image/enoughmoney.png")
	else:
		$hpmultiply/buyhpmultiply.texture_normal = load("res://assets/image/buydamage.png")
	
	if values.shootdelaylvl < 5:
		if values.Coins >= values.shootdelayprice:
			$shootdelay/buyshootdelay.texture_normal = load("res://assets/image/enoughmoney.png")
		else:
			$shootdelay/buyshootdelay.texture_normal = load("res://assets/image/buydamage.png")
	else:
		var shootdelay = 0.6 - (float(values.shootdelaylvl) / 10)
		$shootdelay/buyshootdelay.texture_normal = load("res://assets/image/buydamage.png")
		$shootdelay/name.visible = false
		$shootdelay/buy.visible = false
		$shootdelay/maxlevelreached.visible = true
		$shootdelay/shootdelaytext.set_text("Decrease the\ntime between each\n shot\n\nCurrent Level: "+ str(values.shootdelaylvl)+ "\nCurrent delay: "+ str(shootdelay))



#---------------------------------------------------------


# set the more information text in shop 1


#---------------------------------------------------------

func _on_damage_pressed():
	if $damage.pressed:
		var damage = round(0.5*(values.damagelvl * values.damagelvl))
		var cost =5*(values.damagelvl * values.damagelvl)
		
		$damage.texture_normal = load("res://assets/image/more info background.png")
		$damage/damagetext.visible = true
		$damage/damagetext.set_text("Increase the \ndamage of your \nbullets\n\nCurrent Level: "+ str(values.damagelvl)+ "\nCurrent Damage:"+Globalvariables.smallvalue(damage) +"\nPrice: " + Globalvariables.smallvalue(cost) + " Coins")
	else:
		$damage.texture_normal = load("res://assets/image/shopdamage.png")
		$damage/damagetext.visible = false

func _on_starthp_pressed():
	if $starthp.pressed:
		var hp = values.startBumpHpLvl + (values.startBumpHpLvl * 4)
		var cost = 5*(values.startBumpHpLvl * values.startBumpHpLvl)
		
		$starthp.texture_normal = load("res://assets/image/more info background.png")
		$starthp/starthptext.visible = true
		$starthp/starthptext.set_text("Increase the \nbase hp of your \nBumper\n\nCurrent Level: "+ str(values.startBumpHpLvl)+ "\nCurrent hp: "+Globalvariables.smallvalue(hp)+ "\nPrice: "+ Globalvariables.smallvalue(cost) + " Coins")
	else:
		$starthp/starthptext.visible = false
		$starthp.texture_normal = load("res://assets/image/bumperstarthp.png")

func _on_hpmultiply_pressed():
	if $hpmultiply.pressed:
		var hpmultiply = values.hplevel
		var cost = 100*values.hplevel + (100*(values.hplevel * values.hplevel))
		$hpmultiply/hpmultiplytext.visible = true
		$hpmultiply/hpmultiplytext.set_text("Increase hp\ngain when pressing\nthe correct button\n\nCurrent Level: "+ str(values.hplevel)+ "\nCurrent multiply:"+ Globalvariables.smallvalue(hpmultiply) + "x"  +"\nPrice: "+ Globalvariables.smallvalue(cost))
		$hpmultiply.texture_normal = load("res://assets/image/more info background.png")
	else:
		$hpmultiply/hpmultiplytext.visible = false
		$hpmultiply.texture_normal = load("res://assets/image/hpmultiply.png")

func _on_shootdelay_pressed():
	if $shootdelay.pressed:
		var shootdelay = 0.6 - (float(values.shootdelaylvl) / 10)
		var cost = values.shootdelayprice
		$shootdelay/shootdelaytext.visible = true
		$shootdelay/shootdelaytext.set_text("Decrease the\ntime between each\n shot\n\nCurrent Level: "+ str(values.shootdelaylvl)+ "\nCurrent delay: "+ str(shootdelay)+ "\nPrice: "+Globalvariables.smallvalue(cost))
		$shootdelay.texture_normal = load("res://assets/image/more info background.png")
	else:
		$shootdelay/shootdelaytext.visible = false
		$shootdelay.texture_normal = load("res://assets/image/shopdamage.png")


#----------------------------------------------------------------------------------

# buying the item, checking if you got enough money, reload the enough money check in shop 1


#----------------------------------------------------------------------------------
func _on_buydamage_button_down():
	if Globalvariables.savegame_data.Coins >= 5*(values.damagelvl * values.damagelvl):
		values.Coins -= 5*(values.damagelvl * values.damagelvl)
		values.damagelvl += 1
		var damage = round(0.5*(values.damagelvl * values.damagelvl))
		var cost = 5*(values.damagelvl * values.damagelvl)
		$damage/damagetext.set_text("Increase the \ndamage of your \nbullets\n\nCurrent Level: "+ str(values.damagelvl)+ "\nCurrent Damage:"+Globalvariables.smallvalue(damage) +"\nPrice: " + Globalvariables.smallvalue(cost) + " Coins")
		get_node("Coins/Label").set_text(Globalvariables.smallvalue(values.Coins))
		checkaffordable1()
		Globalvariables.save_data()
	else:
		$damage/buy.visible = false
		$damage/name.visible = false
		$damage/nomoney.visible = true

func _on_buystarthp_button_down():
	if Globalvariables.savegame_data.Coins >= 5*(values.startBumpHpLvl * values.startBumpHpLvl):
		values.Coins -= 5*(values.startBumpHpLvl * values.startBumpHpLvl)
		values.startBumpHpLvl += 1
		var hp = values.startBumpHpLvl + (values.startBumpHpLvl * 4)
		var cost = 5*(values.startBumpHpLvl * values.startBumpHpLvl)
		$starthp/starthptext.set_text("Increase the \nbase hp of your \nBumper\n\nCurrent Level: "+ str(values.startBumpHpLvl)+ "\nCurrent hp: "+Globalvariables.smallvalue(hp)+ "\nPrice: "+ Globalvariables.smallvalue(cost) + " Coins")
		get_node("Coins/Label").set_text(Globalvariables.smallvalue(values.Coins))
		checkaffordable1()
		Globalvariables.save_data()
	else:
		$starthp/name.visible = false
		$starthp/buy.visible = false
		$starthp/nomoney.visible = true

func _on_buyhpmultiply_button_down():
	if Globalvariables.savegame_data.Coins >= (100*values.hplevel + (100*(values.hplevel * values.hplevel))):
		values.Coins -= (100*values.hplevel + (100*(values.hplevel * values.hplevel)))
		values.hplevel += 1
		var hpmultiply = values.hplevel
		var cost = 100*values.hplevel + (100*(values.hplevel * values.hplevel))
		$hpmultiply/hpmultiplytext.set_text("Increase hp\ngain when pressing\nthe correct button\n\nCurrent Level:"+ str(values.hplevel)+ "\nCurrent multiply:"+ Globalvariables.smallvalue(hpmultiply) + "x" +"\nPrice: "+ Globalvariables.smallvalue(cost) + " Coins")
		get_node("Coins/Label").set_text(Globalvariables.smallvalue(values.Coins))
		checkaffordable1()
		Globalvariables.save_data()
		
	else:
		$hpmultiply/buy.visible = false
		$hpmultiply/name.visible = false
		$hpmultiply/nomoney.visible = true

func _on_buyshootdelay_button_down():
	if values.shootdelaylvl < 5:
		if values.Coins >= values.shootdelayprice:
			values.Coins -= values.shootdelayprice
			values.shootdelayprice = values.shootdelayprice * 10
			values.shootdelaylvl += 1
			var shootdelay = 0.6 - (float(values.shootdelaylvl) / 10)
			var cost = values.shootdelayprice
			$shootdelay/shootdelaytext.set_text("Decrease the\ntime between each\n shot\n\nCurrent Level: "+ str(values.shootdelaylvl)+ "\nCurrent delay: "+ str(shootdelay)+ "\nPrice: "+Globalvariables.smallvalue(cost))
			get_node("Coins/Label").set_text(Globalvariables.smallvalue(values.Coins))
			checkaffordable1()
			Globalvariables.save_data()
		else:
			$shootdelay/buy.visible = false
			$shootdelay/name.visible = false
			$shootdelay/nomoney.visible = true
	else:
		$shootdelay/buyshootdelay.texture_normal = load("res://assets/image/enoughmoney.png")
		$shootdelay/name.visible = false
		$shootdelay/buy.visible = false
		$shootdelay/maxlevelreached.visible = true

#------------------------------------------------------------------------------------------------------
#start of shop2
#------------------------------------------------------------------------------------------------------






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

func _on_startlevel_pressed():
	pass # Replace with function body
