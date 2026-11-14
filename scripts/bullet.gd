extends CharacterBody2D

@export var label: Label

@export var direction := Vector2(1, 0)
@export var speed := 500.0

func collision(n: Vector2, d: Vector2) -> Vector2:
	var theta_offset = acos(n.dot(Vector2.RIGHT))
	d = d.rotated(theta_offset)
	d.y = -d.y
	d = d.rotated(-theta_offset)
	return d.normalized()
	
func _ready() -> void:
	direction = direction.normalized()
	
func _process(delta: float) -> void:
	rotation = acos(direction.dot(Vector2.RIGHT))
	position += direction * speed * delta
	if $ShapeCast2D.is_colliding():
		direction = collision($ShapeCast2D.get_collision_normal(0), direction)
