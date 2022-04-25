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
	if values.Coins >= values.hpmultiplycost:
		$hpmultiply/buyhpmultiply.texture_normal = load("res://assets/image/enoughmoney.png")
	else:
		$hpmultiply/buyhpmultiply.texture_normal = load("res://assets/image/buydamage.png")
	
	if values.shootdelaylvl < 5:
		if values.Coins >= values.shootdelayprice:
			$shootdelay/buyshootdelay.texture_normal = load("res://assets/image/enoughmoney.png")
		else:
			$shootdelay/buyshootdelay.texture_normal = load("res://assets/image/buydamage.png")
	else:
		var shootdelay = 0.7 - (float(values.shootdelaylvl) / 10)
		$shootdelay/buyshootdelay.texture_normal = load("res://assets/image/buydamage.png")
		$shootdelay/name.visible = false
		$shootdelay/buy.visible = false
		$shootdelay/maxlevelreached.visible = true
		$shootdelay/shootdelaytext.set_text("Decrease the\ntime between each\nshot\nCurrent Level: "+ str(values.shootdelaylvl)+ "\nCurrent delay:\n"+ str(shootdelay))



#---------------------------------------------------------


# set the more information text in shop 1


#---------------------------------------------------------

func _on_damage_pressed():
	if $damage.pressed:
		var damage = round(0.25*(0.25*(values.damagelvl * values.damagelvl)) + values.damagelvl)
		var nextdamage = round(0.25*(0.25*((values.damagelvl + 1) * (values.damagelvl + 1)))+ (values.damagelvl + 1))
		var cost =5*(values.damagelvl * values.damagelvl)
		
		$damage.texture_normal = load("res://assets/image/more info background.png")
		$damage/damagetext.visible = true
		$damage/damagetext.set_text("Increase the \ndamage of your \nbullets\nCurrent Level: "+ Globalvariables.smallvalue(values.damagelvl)+ "\nChange:\n"+Globalvariables.smallvalue(damage) + " -> "+ Globalvariables.smallvalue(nextdamage)+"\nPrice: " + Globalvariables.smallvalue(cost) + " Coins")
	else:
		$damage.texture_normal = load("res://assets/image/shopdamage.png")
		$damage/damagetext.visible = false

func _on_starthp_pressed():
	if $starthp.pressed:
		var hp = 0.25 *(values.startBumpHpLvl * values.startBumpHpLvl)
		var nexthp = 0.25 *((values.startBumpHpLvl + 1) * (values.startBumpHpLvl + 1))
		var cost = 5*(values.startBumpHpLvl * values.startBumpHpLvl)
		
		$starthp.texture_normal = load("res://assets/image/more info background.png")
		$starthp/starthptext.visible = true
		$starthp/starthptext.set_text("Increase the \nbase hp of your \nBumper\nCurrent Level: "+ Globalvariables.smallvalue(values.startBumpHpLvl)+ "\nChange:\n"+Globalvariables.smallvalue(hp)+ " -> " + Globalvariables.smallvalue(nexthp)+"\nPrice: "+ Globalvariables.smallvalue(cost) + " Coins")
	else:
		$starthp/starthptext.visible = false
		$starthp.texture_normal = load("res://assets/image/bumperstarthp.png")

func _on_hpmultiply_pressed():
	if $hpmultiply.pressed:
		var hpmultiply = pow(2,values.hplevel -1)
		var nexthpmultiply = pow(2,values.hplevel)
		var cost = values.hpmultiplycost
		
		$hpmultiply.texture_normal = load("res://assets/image/more info background.png")
		$hpmultiply/hpmultiplytext.visible = true
		$hpmultiply/hpmultiplytext.set_text("Increase hp\ngain when pressing\nthe correct button\nCurrent Level: "+ Globalvariables.smallvalue(values.hplevel)+ "\nChange:\n"+ Globalvariables.smallvalue(hpmultiply) + "x" + " -> " + Globalvariables.smallvalue(nexthpmultiply) + "x" +"\nPrice: "+ Globalvariables.smallvalue(cost))
		
	else:
		$hpmultiply/hpmultiplytext.visible = false
		$hpmultiply.texture_normal = load("res://assets/image/hpmultiply.png")

func _on_shootdelay_pressed():
	if $shootdelay.pressed:
		$shootdelay.texture_normal = load("res://assets/image/more info background.png")
		$shootdelay/shootdelaytext.visible = true
		if values.shootdelaylvl < 5:
			var shootdelay = 0.7 - (float(values.shootdelaylvl) / 10 )
			var nextshootdelay = 0.7 - (float(values.shootdelaylvl + 1) /10 )
			var cost = values.shootdelayprice
			$shootdelay/shootdelaytext.set_text("Decrease the\ntime between each\nshot\nCurrent Level: "+ str(values.shootdelaylvl)+ "\nChange:\n"+ str(shootdelay)+ " -> " + str(nextshootdelay)  +"\nPrice: "+Globalvariables.smallvalue(cost))
		else:
			$shootdelay/shootdelaytext.set_text("Decrease the\ntime between each\nshot\nCurrent Level:"+ str(values.shootdelaylvl) + "\nCurrently:\n" + str( 0.7 - (float(values.shootdelaylvl) / 10 )))
			
	else:
		$shootdelay/shootdelaytext.visible = false
		$shootdelay.texture_normal = load("res://assets/image/shootdelayimage.png")


#----------------------------------------------------------------------------------

# buying the item, checking if you got enough money, reload the enough money check in shop 1


#----------------------------------------------------------------------------------
func _on_buydamage_button_down():
	if Globalvariables.savegame_data.Coins >= 5*(values.damagelvl * values.damagelvl):
		values.Coins -= 5*(values.damagelvl * values.damagelvl)
		values.damagelvl += 1
		var damage = round(0.25*(0.25*(values.damagelvl * values.damagelvl)) + values.damagelvl)
		var nextdamage = round(0.25*(0.25*((values.damagelvl + 1) * (values.damagelvl + 1)))+ (values.damagelvl + 1))
		var cost = 5*(values.damagelvl * values.damagelvl)
		$damage/damagetext.set_text("Increase the \ndamage of your \nbullets\nCurrent Level: "+ Globalvariables.smallvalue(values.damagelvl)+ "\nChange:\n"+Globalvariables.smallvalue(damage) + " -> "+ Globalvariables.smallvalue(nextdamage)+"\nPrice: " + Globalvariables.smallvalue(cost) + " Coins")
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
		var hp = 0.25 *(values.startBumpHpLvl * values.startBumpHpLvl)
		var nexthp = 0.25 *((values.startBumpHpLvl + 1) * (values.startBumpHpLvl + 1))
		var cost = 5*(values.startBumpHpLvl * values.startBumpHpLvl)
		$starthp/starthptext.set_text("Increase the \nbase hp of your \nBumper\nCurrent Level: "+ Globalvariables.smallvalue(values.startBumpHpLvl)+ "\nChange:\n"+Globalvariables.smallvalue(hp)+ " -> " + Globalvariables.smallvalue(nexthp)+"\nPrice: "+ Globalvariables.smallvalue(cost) + " Coins")
		get_node("Coins/Label").set_text(Globalvariables.smallvalue(values.Coins))
		checkaffordable1()
		Globalvariables.save_data()
	else:
		$starthp/name.visible = false
		$starthp/buy.visible = false
		$starthp/nomoney.visible = true

func _on_buyhpmultiply_button_down():
	if Globalvariables.savegame_data.Coins >= values.hpmultiplycost:
		values.Coins -= values.hpmultiplycost
		values.hplevel += 1
		values.hpmultiplycost *= 5
		var hpmultiply = pow(2,values.hplevel -1)
		var nexthpmultiply = pow(2,values.hplevel)
		var cost = values.hpmultiplycost
		$hpmultiply/hpmultiplytext.set_text("Increase hp\ngain when pressing\nthe correct button\nCurrent Level: "+ Globalvariables.smallvalue(values.hplevel)+ "\nChange:\n"+ Globalvariables.smallvalue(hpmultiply) + "x" + " -> " + Globalvariables.smallvalue(nexthpmultiply) + "x" +"\nPrice: "+ Globalvariables.smallvalue(cost))
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
			var shootdelay = 0.7 - (float(values.shootdelaylvl) / 10)
			var nextshootdelay = 0.7 - (float(values.shootdelaylvl + 1) /10 )
			var cost = values.shootdelayprice
			$shootdelay/shootdelaytext.set_text("Decrease the\ntime between each\nshot\nCurrent Level: "+ str(values.shootdelaylvl)+ "\nChange:\n"+ str(shootdelay)+ " -> " + str(nextshootdelay)  +"\nPrice: "+Globalvariables.smallvalue(cost))
			get_node("Coins/Label").set_text(Globalvariables.smallvalue(values.Coins))
			checkaffordable1()
			Globalvariables.save_data()
		else:
			$shootdelay/buy.visible = false
			$shootdelay/name.visible = false
			$shootdelay/nomoney.visible = true

#------------------------------------------------------------------------------------------------------
#start of shop2
#------------------------------------------------------------------------------------------------------

func _on_exit2_ready():
	checkaffordable2()

func checkaffordable2():
	if values.penaltylevel > 1:
		if values.Coins >= values.penaltylevelprice:
			$lessloss/buydlessloss.texture_normal = load("res://assets/image/enoughmoney.png")
		else:
			$lessloss/buydlessloss.texture_normal = load("res://assets/image/buydamage.png")
	else:
		$lessloss/lesslosstext.set_text("Decrease loss\nof hp when clicking\nthe wrong button\nCurrent Level:" + str(values.penaltylevelC) + "\nCurrently:\n" + Globalvariables.smallvalue(values.penaltylevel) + "x")
		$lessloss/buydlessloss.texture_normal = load("res://assets/image/buydamage.png")
		$lessloss/maxlevel.visible = true
		$lessloss/buy.visible = false
		$lessloss/name.visible = false
	if values.Coins >= 0.5*(values.timepenaltylevel * values.timepenaltylevel) + values.timepenaltylevel:
		$moretime/buymoretime.texture_normal = load("res://assets/image/enoughmoney.png")
	else:
		$moretime/buymoretime.texture_normal = load("res://assets/image/buydamage.png")
	
	if values.mintime < 10:
		if values.Coins >= values.mintimeprice:
			$mintime/buymintime.texture_normal = load("res://assets/image/enoughmoney.png")
		else:
			$mintime/buymintime.texture_normal = load("res://assets/image/buydamage.png")
	else:
		$mintime/mintimetext.set_text("Increase the\nminimum time you\nhave to gain hp\nCurrent Level:" + str(values.mintime - 2) + "\nCurrently:\n" + str(values.mintime))
		$mintime/buymintime.texture_normal = load("res://assets/image/buydamage.png")
		$mintime/buy.visible = false
		$mintime/name.visible = false
		$mintime/maxlevel.visible = true
	if values.highestlevel > values.startlevel + 2:
		if values.Coins >= 0.25*((values.startlevel/10) + 1)* (values.startlevel * values.startlevel):
			$startlevel/buystartlevel.texture_normal = load("res://assets/image/enoughmoney.png")
		else:
			$startlevel/buystartlevel.texture_normal = load("res://assets/image/buydamage.png")
	else:
		$startlevel/buystartlevel.texture_normal = load("res://assets/image/buydamage.png")
		$startlevel/buy.visible = false
		$startlevel/higher.visible = true
		$startlevel/name.visible = false
		$startlevel/higher/level.set_text(Globalvariables.smallvalue(values.startlevel + 3))



func _on_lessloss_pressed():
	
	if $lessloss.pressed:
		$lessloss/lesslosstext.visible = true
		$lessloss.texture_normal = load("res://assets/image/more info background.png")
		if values.penaltylevel > 1:
			var loss = values.penaltylevel
			var nextloss = values.penaltylevel - 1
			var cost = values.penaltylevelprice
		
			
			$lessloss/lesslosstext.set_text("Decrease loss\nof hp when clicking\nthe wrong button\nCurrent Level:"+ str(values.penaltylevelC) + "\nChange:\n" + str(loss) + "x" + " -> " + str(nextloss) + "x" +"\nPrice: "+ Globalvariables.smallvalue(cost))
			
		else:
			
			$lessloss/lesslosstext.set_text("Decrease loss\nof hp when clicking\nthe wrong button\nCurrent Level:" + str(values.penaltylevelC) + "\nCurrently:\n" + Globalvariables.smallvalue(values.penaltylevel) + "x")
			
		
	else:
		$lessloss.texture_normal = load("res://assets/image/lessloss.png")
		$lessloss/lesslosstext.visible = false


func _on_moretime_pressed():
	if $moretime.pressed:
		var time = values.timepenaltylevel
		var nextime = values.timepenaltylevel + 1
		var cost = 0.5*(values.timepenaltylevel * values.timepenaltylevel) + values.timepenaltylevel
		$moretime.texture_normal = load("res://assets/image/more info background.png")
		$moretime/moretimetext.set_text("Increase the\ntime you have\nto gain hp\nCurrent Level:" + Globalvariables.smallvalue(time) + "\nChange:\n" + Globalvariables.smallvalue(time) + " -> " + Globalvariables.smallvalue(nextime)+"\nPrice: " + Globalvariables.smallvalue(cost))
		$moretime/moretimetext.visible = true
	else:
		$moretime.texture_normal = load("res://assets/image/moretime.png")
		$moretime/moretimetext.visible = false


func _on_mintime_pressed():
	
	if $mintime.pressed:
		$mintime.texture_normal = load("res://assets/image/more info background.png")
		$mintime/mintimetext.visible = true
		var level = values.mintime - 2
		if values.mintime < 10:
			var mintime = values.mintime
			
			var nextmintime = values.mintime + 1
			var cost = values.mintimeprice
			
			$mintime/mintimetext.set_text("Increase the\nminimum time you\nhave to gain hp\nCurrent Level:"+ Globalvariables.smallvalue(level)+ "\nChange:\n" + Globalvariables.smallvalue(mintime) + " -> " + Globalvariables.smallvalue(nextmintime)+"\nPrice: " + Globalvariables.smallvalue(cost))
			
		else:
			$mintime/mintimetext.set_text("Increase the\nminimum time you\nhave to gain hp\nCurrent Level:"+ Globalvariables.smallvalue(level) + "\nCurrently:\n" + str(values.mintime))
	else:
		$mintime.texture_normal = load("res://assets/image/morestarttime.png")
		$mintime/mintimetext.visible = false


func _on_startlevel_pressed():
	if $startlevel.pressed:
		var startlevel = values.startlevel
		var nextstartlevel = values.startlevel + 1
		var cost = 0.25*((values.startlevel/10) + 1)* (values.startlevel * values.startlevel)
		$startlevel.texture_normal = load("res://assets/image/more info background.png")
		$startlevel/startleveltext.set_text("Increase the\nlevel that your\nstarting to play in\nCurrent Level:" + Globalvariables.smallvalue(startlevel)+ "\nChange:\n" + Globalvariables.smallvalue(startlevel) + " -> " + Globalvariables.smallvalue(nextstartlevel)  + "\nPrice: "+ Globalvariables.smallvalue(cost))
		$startlevel/startleveltext.visible = true
	else:
		$startlevel.texture_normal = load("res://assets/image/startlevel.png")
		$startlevel/startleveltext.visible = false





func _on_buydlessloss_button_down():
	if values.penaltylevel > 1:
		if values.Coins >= values.penaltylevelprice:
			values.Coins -= values.penaltylevelprice
			values.penaltylevel -= 1
			values.penaltylevelC += 1
			values.penaltylevelprice = values.penaltylevelprice * 10
			var loss = values.penaltylevel
			var nextloss = values.penaltylevel - 1
			var cost = values.penaltylevelprice
			$lessloss/lesslosstext.set_text("Decrease loss\nof hp when clicking\nthe wrong button\nCurrent Level:"+ str(values.penaltylevelC) + "\nChange:\n" + str(loss) + "x" + " -> " + str(nextloss) + "x" +"\nPrice: "+ Globalvariables.smallvalue(cost))
			get_node("Coins/Label").set_text(Globalvariables.smallvalue((values.Coins)))
			checkaffordable2()
			Globalvariables.save_data()
		else:
			checkaffordable2()
			$lessloss/buy.visible = false
			$lessloss/name.visible = false
			$lessloss/nomoney.visible = true

func _on_buymoretime_button_down():
	if values.Coins >=0.5*(values.timepenaltylevel * values.timepenaltylevel) + values.timepenaltylevel:
		values.Coins -= 0.5*(values.timepenaltylevel * values.timepenaltylevel) + values.timepenaltylevel
		values.timepenaltylevel += 1
		var time = values.timepenaltylevel
		var nextime = values.timepenaltylevel + 1
		var cost = 0.5*(values.timepenaltylevel * values.timepenaltylevel) + values.timepenaltylevel
		$moretime/moretimetext.set_text("Increase the\ntime you have\nto gain hp\nCurrent Level:" + Globalvariables.smallvalue(time) + "\nChange:\n" + Globalvariables.smallvalue(time) + " -> " + Globalvariables.smallvalue(nextime)+"\nPrice: " + Globalvariables.smallvalue(cost))
		get_node("Coins/Label").set_text(Globalvariables.smallvalue(values.Coins))
		checkaffordable2()
		Globalvariables.save_data()
	else:
		$moretime/buy.visible = false
		$moretime/name.visible = false
		$moretime/nomoney.visible = true


func _on_buymintime_button_down():
	if values.mintime < 10:
		if values.Coins >= values.mintimeprice:
			values.Coins -= values.mintimeprice
			values.mintime += 1
			values.mintimeprice = values.mintimeprice * 5
			var mintime = values.mintime
			var level = values.mintime - 2
			var nextmintime = values.mintime + 1
			var cost = values.mintimeprice
			$mintime/mintimetext.set_text("Increase the\nminimum time you\nhave to gain hp\nCurrent Level:"+ Globalvariables.smallvalue(level)+ "\nChange:\n" + Globalvariables.smallvalue(mintime) + " -> " + Globalvariables.smallvalue(nextmintime)+"\nPrice: " + Globalvariables.smallvalue(cost))
			get_node("Coins/Label").set_text(Globalvariables.smallvalue((values.Coins)))
			checkaffordable2()
			Globalvariables.save_data()
		else:
			$mintime/buy.visible = false
			$mintime/name.visible = false
			$mintime/nomoney.visible = true

func _on_buystartlevel_button_down():
	if values.highestlevel > values.startlevel + 2:
		if values.Coins >= 0.25*((values.startlevel/10) + 1)* (values.startlevel * values.startlevel):
			values.Coins -= 0.25*((values.startlevel/10) + 1)* (values.startlevel * values.startlevel)
			values.startlevel += 1
			var startlevel = values.startlevel
			var nextstartlevel = values.startlevel + 1
			var cost = 0.25*((values.startlevel/10) + 1)* (values.startlevel * values.startlevel)
			$startlevel/startleveltext.set_text("Increase the\nlevel that your\nstarting to play in\nCurrent Level:" + Globalvariables.smallvalue(startlevel)+ "\nChange:\n" + Globalvariables.smallvalue(startlevel) + " -> " + Globalvariables.smallvalue(nextstartlevel) + "\nPrice: "+ Globalvariables.smallvalue(cost))
			get_node("Coins/Label").set_text(Globalvariables.smallvalue(values.Coins))
			checkaffordable2()
			Globalvariables.save_data()
		else:
			$startlevel/buy.visible = false
			$startlevel/name.visible = false
			$startlevel/nomoney.visible = true
