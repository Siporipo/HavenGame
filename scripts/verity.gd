extends CharacterBody2D

var health = 100
@export var camera_ref: Camera2D
var next_attack_timeout = 5.0
var attack = "idle"
var target_pos := Vector2(0, 0)

func _process(delta: float) -> void:
	if next_attack_timeout < 0:
		next_attack_timeout = 5 + randf() * 5
		var randint = clampi(int(randf() * 2 + 1), 1, 3)
		if randint == 1:
			attack = "sine_hover"
		elif randint == 2:
			attack = "diagonal"
		elif randint == 3:
			attack = "knuckles"
	else:
		if attack == "sine_hover":
			$AnimatedSprite2D.play("float")
			target_pos = (Vector2(sin(next_attack_timeout * 2) * 1000, cos(next_attack_timeout * 2) * 500) - position) / 10
		elif attack == "diagonal":
			$AnimatedSprite2D.play("idle")
			if next_attack_timeout < 5:
				target_pos = Vector2(60 * next_attack_timeout, 30 * next_attack_timeout)
			else:
				target_pos = Vector2(-50 * (next_attack_timeout - 5), 50 * (next_attack_timeout - 5))
			
		elif attack == "knuckles":
			$AnimatedSprite2D.play("shoot")
			target_pos = Vector2(randf() * 1000 -500, -randf() * 500 + 250)
			
	position += (target_pos - position) / 5
	next_attack_timeout -= delta


func _on_area_2d_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	health -= 5
	body.queue_free()
	if health <= 0:
		queue_free()
		Autoload.enemy_death()
