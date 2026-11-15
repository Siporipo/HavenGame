extends CharacterBody2D

var health = 10
@export var dmove = Vector2(100, 100)

func _process(delta: float) -> void:
	position += dmove * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	health -= 5
	(area.get_parent()).queue_free()
	if health <= 0:
		queue_free()
