extends Node

const save_path = "user://save.txt"

var corrBumperHp
var BumperHp 
var start = false
var level
var time = 10



var savegame_data = {
	"Coins": 0,
	"shootdelayprice": 100,                      #beginn 100
	"penaltylevel": 5,                           #beginn: 5
	"startlevel": 0,                         #beginn: 0
	"timepenalty": 0,                         #beginn: 0
	
	"damagelvl": 1,                
	"startBumpHpLvl": 1,                
	"hplevel": 1,      
	"shootdelaylvl": 1                     
}                                   


func _ready():
	
	level = savegame_data.startlevel
	BumperHp = savegame_data.startBumpHpLvl + (savegame_data.startBumpHpLvl * 4)
	print(typeof(savegame_data.Coins))
	load_data()


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
	if orgvalue >= 1000 and orgvalue < 1000000:
		value = str(stepify(float(value)/1000, 0.01)) + "K"
	if orgvalue >= 1000000:
		value = str(stepify(float(value)/1000000, 0.01)) + "M"
	return str(value)
