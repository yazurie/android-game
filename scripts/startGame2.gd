extends Button

var plus = false
var blink = true

func _ready() -> void:
	visible = true


func _physics_process(_delta):
	if blink:
		get_parent().modulate.a += 0.03
	if get_parent().modulate.a > 0.8:
		get_parent().modulate.a = 0.8
		blink = false
	
	if plus == false:
		modulate.a -= 0.013
	if modulate.a <= 0.13:
		
		plus = true
	if plus:
		modulate.a += 0.013
		if modulate.a > 0.9:
			plus = false


func _on_Button_button_down() -> void:
	get_parent().get_node("Timer").start()
	get_parent().get_node("Time").visible = true
	get_tree().paused = false
	get_parent().get_node("spawn").start()
	queue_free()
