extends CharacterBody2D
@onready var mov_anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var rapid_j: RayCast2D = $Rapid_Jump




const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		velocity.y = 0
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
	elif rapid_j.is_colliding() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
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

		
