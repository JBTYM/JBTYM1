extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("walk")

func physics_update(delta: float) -> void:
	# var input_direction_x := Input.get_axis("turn_left", "turn_right")
	# player.velocity.x = player.speed * input_direction_x
	# player.velocity.y += player.gravity * delta
	
	var forwardVector = -Vector3.FORWARD.rotated(Vector3.UP, player.rotation.y)
	player.velocity = -forwardVector * player.speed 
	
	if Input.is_action_pressed("turn_left"):
		player.rotation.z += player.Vec3Z.y - player.turn_speed #* V_LOOK_SENS
		player.rotation.z = clamp(player.rotation.x, -50, 90)
		player.rotation.y += player.Vec3Z.y + player.turn_speed #* M_LOOK_SENS

	elif Input.is_action_pressed("turn_right"):
		player.rotation.z -= player.Vec3Z.y + player.turn_speed #* V_LOOK_SENS
		player.rotation.z = clamp(player.rotation.x, -50, 90)
		player.rotation.y -= player.Vec3Z.y + player.turn_speed #* M_LOOK_SENS
	
	
	player.move_and_slide()

	if not Input.is_action_just_pressed("move_forward"):
		player.velocity.x = 0
		player.velocity.z = 0
		finished.emit(IDLE)
	elif not player.is_on_floor():
		finished.emit(FALLING)
	# elif Input.is_action_just_pressed("move_forward"):
	# 	finished.emit(JUMPING)
	# elif is_equal_approx(input_direction_x, 0.0):
	# 	finished.emit(IDLE)
