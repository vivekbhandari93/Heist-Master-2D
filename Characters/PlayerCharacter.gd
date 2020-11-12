extends "res://Characters/TemplateCharacter.gd"

var velocity = Vector2.ZERO

func _physics_process(delta):
	move()
	move_and_slide(velocity)


func move():
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("down"):
		velocity.y = clamp(velocity.y + SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("up"):
		velocity.y = clamp(velocity.y - SPEED, -MAX_SPEED, 0)
	elif Input.is_action_pressed("right"):
		velocity.x = clamp(velocity.x + SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("left"):
		velocity.x = clamp(velocity.x - SPEED, -MAX_SPEED, 0)
	
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)


func _input(event):
	if Input.is_action_just_pressed("torch_toggle"):
		$Torch.enabled = not $Torch.ene
