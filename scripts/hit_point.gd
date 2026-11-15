extends Area2D

func _process(delta: float) -> void:
	if Autoload.enemies_in_level == 0:
		$AnimatedSprite2D.play("open")
	else:
		$AnimatedSprite2D.play("closed")

func _on_body_entered(body: Node2D) -> void:
	if Autoload.enemies_in_level == 0:
		Autoload.level_finished()
