extends CharacterBody2D
@onready var mov_anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var rapid_j: RayCast2D = $Rapid_Jump




const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var Jumps_Left = 2


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
			velocity += get_gravity() * delta
	# Handle jump.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if Input.is_action_just_pressed("ui_left"):
			mov_anim.flip_h = true
		elif  Input.is_action_just_pressed("ui_right"):
			mov_anim.flip_h = false
		mov_anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		mov_anim.play("idle")

	move_and_slide()

		
