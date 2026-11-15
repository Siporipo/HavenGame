extends Node

signal level_done

var player_available = false

var level = 0
var max_level = 9

var enemies_in_level = 0

func enemy_death() -> void:
	enemies_in_level -= 1

func level_finished():
	if level + 1 > max_level:
		max_level = level + 1
	level_done.emit()
