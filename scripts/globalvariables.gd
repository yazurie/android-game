extends Node

const save_path = "user://save.txt"

var corrBumperHp
var BumperHp 
var start = false
var level
var time = 10



var savegame_data = {
	"Coins": 0,
	"hpmultiply": 1,                        #beginn: 1
	"startBumpHp": 5,                       #beginn: 5
	"shootdelay": 0.5,                      #beginn: 0.5                         #beginn: 1
	"penalty": 5,                           #beginn: 5
	"startlevel": 0,                         #beginn: 0
	"timepenalty": 0,                         #beginn: 0
	
	"damagelvl": 1
}


func _ready():
	level = savegame_data.startlevel
	BumperHp = savegame_data.startBumpHp
	print(typeof(savegame_data.Coins))
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
	
	
	
	
