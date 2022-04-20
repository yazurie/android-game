extends Label

var font
var maxsize = 170


func _ready():
	font = DynamicFont.new()
	font.font_data = load("res://assets/Font/flappyfont.TTF")
	font.size = 100
	set("custom_fonts/font", font)


func _on_screen_score_changed():
	set_text(Globalvariables.smallvalue(get_parent().get_node("screen").Score))


