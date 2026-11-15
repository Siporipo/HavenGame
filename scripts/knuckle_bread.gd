extends CharacterBody2D

var health = 10

func _on_area_2d_area_entered(area: Area2D) -> void:
	health -= 5
	(area.get_parent()).queue_free()
