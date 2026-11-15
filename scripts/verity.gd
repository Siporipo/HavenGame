extends CharacterBody2D

var health = 100
@export var camera_ref: Camera2D
var next_attack_timeout = 5.0
var attack = "idle"
var target_pos := Vector2(0, 0)
var hit_tick = 0

func _ready() -> void:
	z_index = 999

func _process(delta: float) -> void:
	$ProgressBar.value = health
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
		if attack == "idle":
			$AnimatedSprite2D.play("idle")
		elif attack == "sine_hover":
			target_pos = Vector2(cos(next_attack_timeout * 4) * 500, sin(next_attack_timeout * 6) * 300) + camera_ref.position - Vector2(0, 50)
			$AnimatedSprite2D.play("float")
		elif attack == "diagonal":
			target_pos = camera_ref.position + Vector2(20 * (next_attack_timeout-7), -20 * (next_attack_timeout - 7))- Vector2(0, 50)
			$AnimatedSprite2D.play("float")
	position += (target_pos - position) / 10
	next_attack_timeout -= delta
	if hit_tick > 0:
		$AnimatedSprite2D.play("hit")
	hit_tick -= 1

func _on_area_2d_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	health -= 1
	body.queue_free()
	hit_tick = 5
	if health <= 0:
		print("Verity has been slain")
		queue_free()
		Autoload.enemy_death()
