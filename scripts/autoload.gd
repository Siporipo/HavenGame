extends Node

var level = 0
var max_level = 1

var enemies_in_level = 0

func enemy_death() -> void:
	enemies_in_level -= 1
