extends Node2D


var SquarePosy = [300, 570, 840]
var SquarePosx = [30,265, 500]
var Childs = []
var chosen
var lastchosen
var Score = 0
var combo : float = 1
signal winchangechosen
signal losechangechosen

func _ready() -> void:
	get_tree().paused = true
	print("hehehedheh")

func _physics_process(delta: float) -> void:
	$Time.set_text(str(stepify($Timer.time_left, 0.1)))

func spawn():
	for y in SquarePosy:
		for x in SquarePosx:
			var Square_instance = load("res://scenes/SquareButton.tscn").instance()
			Square_instance.rect_position.y = y
			Square_instance.rect_position.x = x
			add_child(Square_instance)
			Childs.append(Square_instance)
	print(Childs)

func _on_spawn_timeout() -> void:
	spawn()
	$setCorButton.start()
	
func _on_setCorButton_timeout() -> void:

	chosen = Childs[randi() % Childs.size()]
	chosen.chosen = true
	chosen.modulate = "373636"
	Childs.erase(chosen)
	lastchosen = chosen
	$delayset.start()

func _on_delayset_timeout() -> void:
	emit_signal("losechangechosen")

func _on_Game2_winchangechosen() -> void:
	$delayset.stop()
	lastchosen.chosen = false
	lastchosen.modulate = "ffffff"
	Childs.append(lastchosen)
	$setCorButton.start()

func _on_Game2_losechangechosen() -> void:
	combo = 1
	lastchosen.chosen = false
	lastchosen.modulate = "ffffff"
	Childs.append(lastchosen)
	$setCorButton.start()
	$Score/bonus.set_text(str(combo)+ "x")

func _on_Timer_timeout() -> void:
	get_tree().reload_current_scene()
