extends Node2D

var BULLET := preload("res://scenes/bullet.tscn")
@export var bullet_parent: Node
const offset = 100
@export var target: Node2D
var mouse_vec: Vector2

func _process(delta: float) -> void:
	mouse_vec = (get_global_mouse_position() - position).normalized()
	if target != null:
		position = target.position + mouse_vec * offset
	else:
		position = mouse_vec * offset
	$Sprite2D.rotation = acos(mouse_vec.dot(Vector2.RIGHT))
	if Input.is_action_just_pressed("Shoot"):
		var bullet_instance = BULLET.instantiate()
		bullet_instance.direction = mouse_vec
		bullet_instance.speed = 200
		bullet_instance.position = position
		bullet_parent.add_child(bullet_instance)
