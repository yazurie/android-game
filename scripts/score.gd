extends Label

var font
var maxsize = 250


func _ready():
	font = DynamicFont.new()
	font.font_data = load("res://assets/Font/flappyfont.TTF")
	font.size = 170
	set("custom_fonts/font", font)


func _on_screen_score_changed():
	set_text(str(get_parent().get_node("screen").Score))
	font.size += 10
	
	if font.size > maxsize:
		font.size = maxsize + 10
