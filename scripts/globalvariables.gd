extends Node

const save_path = "user://save.txt"

var corrBumperHp
var BumperHp 
var start = false
var level
var time = 9
var bonus



var savegame_data = {
	"highestlevel": 0,
	"Coins": 10000000,
	"shootdelayprice": 100,                      #beginn 100
	"penaltylevelprice": 500,  
	"mintimeprice": 100,
	"hpmultiplycost": 100,
	
	"damagelvl": 37,                
	"startBumpHpLvl": 42,                
	"hplevel": 5,      
	"shootdelaylvl": 1,   
	
	"penaltylevelC": 3,                   #beginn 1
	"penaltylevel": 3,                    #beginn 5
	"timepenaltylevel": 1,                     #beginn 1
	"mintime": 3,                              #beginn 3
	 "startlevel": 48                 #beginn 1
}                                   


func _ready():
	bonus = 1
	level = savegame_data.startlevel - 1
	BumperHp =  0.25 *(savegame_data.startBumpHpLvl * savegame_data.startBumpHpLvl)

	#load_data()


func save_data():
	var save_game = File.new()
	save_game.open_encrypted_with_pass(save_path, File.WRITE, "Elfenhelfen1!")
	save_game.store_line(to_json(savegame_data))
	save_game.close()

func load_data():
	var save_game = File.new()
	if not save_game.file_exists((save_path)):
		save_data()
		return
	
	save_game.open_encrypted_with_pass(save_path, File.READ, "Elfenhelfen1!")
	savegame_data = parse_json(save_game.get_line())
	
	
	
func smallvalue(value):
	var orgvalue = value
	if orgvalue < 1000:
		value = stepify(value, 0.01)
	if orgvalue >= 1000 and orgvalue < 1000000:
		value = str(stepify(float(value)/1000, 0.01)) + "K"
	if orgvalue >= 1000000:
		value = str(stepify(float(value)/1000000, 0.01)) + "M"
	return str(value)
func enemyvalue(value):
	var orgvalue = value
	if value < 1000:
		value = stepify(value, 1)
	if orgvalue >= 1000 and orgvalue < 1000000:
		value = str(stepify(float(value)/1000, 1)) + "K"
	if orgvalue >= 1000000:
		value = str(stepify(float(value)/1000000, 1)) + "M"
	return str(value)
func Bumpervalue(value):
	var orgvalue = value
	if orgvalue < 1000:
		value = stepify(value, 1)
	if orgvalue >= 1000 and orgvalue < 1000000:
		value = str(stepify(float(value)/1000, 0.1)) + "K"
	if orgvalue >= 1000000:
		value = str(stepify(float(value)/1000000, 0.1)) + "M"
	return str(value)
