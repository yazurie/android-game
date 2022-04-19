extends TextureButton




func _on_shop_button_down():
	Globalvariables.level -= 1
	get_tree().paused = false
	get_tree().change_scene("res://scenes/shop.tscn")
