extends CharacterBody2D
@onready var mov_anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var rapid_j: RayCast2D = $Rapid_Jump

var Multiply = 0.05
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var Jumps_Left = 2
var offset = 5

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if is_on_floor():
		velocity.y = 0
		Jumps_Left = 2
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			Jumps_Left -= 1
	elif rapid_j.is_colliding() and Input.is_action_just_pressed("ui_accept"):
		Jumps_Left = 1
		velocity.y = JUMP_VELOCITY
	else:
		if Jumps_Left >= 1 and Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			Jumps_Left -= 1
		else:
			velocity += get_gravity() * 1.5  * delta
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		offset = velocity.x
		if SPEED*Multiply < SPEED:
			velocity.x = direction * (SPEED * Multiply)
		else:
			velocity.x = direction * SPEED
		Multiply += 0.05
		mov_anim.flip_h = (-direction + 1) /2
		mov_anim.play("run")
	else:
		Multiply = 0.05
		offset *= 0.9
		velocity.x = offset
		mov_anim.play("idle")
	
	move_and_slide()
