extends Label

var font


func _ready():
	font = DynamicFont.new()
	font.font_data = load("res://assets/Font/flappyfont.TTF")
	font.size = 200
	set("custom_fonts/font", font)


func _on_screen_score_changed():
	set_text(str(get_parent().get_node("screen").Score))
	font.size += 10
	
	if font.size > 420:
		font.size = 425
