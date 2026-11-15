extends Node2D

var BULLET := preload("res://scenes/bullet.tscn")
const offset = 10
var mouse_vec: Vector2

func _process(_delta: float) -> void:
	mouse_vec = (get_global_mouse_position() - (get_parent().position - Vector2(0, 12))).normalized()
	position = mouse_vec * offset + Vector2(0, -8)
	$Sprite2D.rotation = acos(mouse_vec.dot(Vector2.RIGHT))
	if mouse_vec.y < 0:
		$Sprite2D.rotation = -$Sprite2D.rotation
	if Input.is_action_just_pressed("Shoot"):
		var bullet_instance = BULLET.instantiate()
		bullet_instance.direction = mouse_vec
		bullet_instance.speed = 200
		bullet_instance.position = get_parent().position + Vector2(0, -12) + mouse_vec * offset
		get_parent().get_parent().add_child(bullet_instance)
