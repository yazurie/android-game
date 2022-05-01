extends TextureButton


var chosen = false



func _on_SquareButton_button_down() -> void:
	if chosen == true:
		get_parent().Score += float(1) * get_parent().combo
		get_parent().combo += 0.05
		get_parent().get_node("Timer").wait_time = get_parent().get_node("Timer").time_left + 0.5
		get_parent().get_node("Timer").stop()
		get_parent().get_node("Timer").start()
		get_parent().emit_signal("winchangechosen")
	else:
		get_parent().Score -= 1
		get_parent().combo = 1
		if  get_parent().get_node("Timer").time_left - 1 > 0:
			get_parent().get_node("Timer").wait_time = get_parent().get_node("Timer").time_left - 1
			get_parent().get_node("Timer").stop()
			get_parent().get_node("Timer").start()
		else:
			get_tree().reload_current_scene()
	get_parent().get_node("Score").set_text(Globalvariables.smallvalue(get_parent().Score))
	get_parent().get_node("Score/bonus").set_text(str(get_parent().combo) + "x")

