extends Control

signal load_level
signal back_to_main_menu

func level1():
	Autoload.level = 1
	load_level.emit()
func level2():
	Autoload.level = 2
	load_level.emit()
func level3():
	Autoload.level = 3
	load_level.emit()
func level4():
	Autoload.level = 4
	load_level.emit()
func level5():
	Autoload.level = 5
	load_level.emit()
func level6():
	Autoload.level = 6
	load_level.emit()
func level7():
	Autoload.level = 7
	load_level.emit()
func level8():
	Autoload.level = 8
	load_level.emit()
func level9():
	Autoload.level = 9
	load_level.emit()
func menu_request():
	back_to_main_menu.emit()

func _ready() -> void:
	%lvl1.pressed.connect(level1)
	%lvl1.add_theme_color_override("font_color", Color(1, 1, 1, 1))
	if Autoload.max_level > 1:
		%lvl2.pressed.connect(level2)
		%lvl2.add_theme_color_override("font_color", Color(1, 1, 1, 1))
		if Autoload.max_level > 2:
			%lvl3.pressed.connect(level3)
			%lvl3.add_theme_color_override("font_color", Color(1, 1, 1, 1))
			if Autoload.max_level > 3:
				%lvl4.pressed.connect(level4)
				%lvl4.add_theme_color_override("font_color", Color(1, 1, 1, 1))
				if Autoload.max_level > 4:
					%lvl5.pressed.connect(level5)
					%lvl5.add_theme_color_override("font_color", Color(1, 1, 1, 1))
					if Autoload.max_level > 5:
						%lvl6.pressed.connect(level6)
						%lvl6.add_theme_color_override("font_color", Color(1, 1, 1, 1))
						if Autoload.max_level > 6:
							%lvl7.pressed.connect(level7)
							%lvl7.add_theme_color_override("font_color", Color(1, 1, 1, 1))
							if Autoload.max_level > 7:
								%lvl8.pressed.connect(level8)
								%lvl8.add_theme_color_override("font_color", Color(1, 1, 1, 1))
								if Autoload.max_level > 8:
									%lvl9.pressed.connect(level9)
									%lvl9.add_theme_color_override("font_color", Color(1, 1, 1, 1))
	%Button.pressed.connect(menu_request)
