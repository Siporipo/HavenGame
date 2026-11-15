extends CharacterBody2D

@export var label: Label

@export var direction := Vector2(1, 0)
@export var speed := 200.0
var tick = 0

func _ready() -> void:
	direction = direction.normalized()
	
func _process(delta: float) -> void:
	if tick > 1000:
		queue_free()
	rotation = acos(direction.dot(Vector2.RIGHT))
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		direction = direction.bounce(collision.get_normal())
	tick += 1
