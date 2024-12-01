extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0.0
	print("entering idle")
	player.animation_player.play("idle")

func physics_update(_delta: float) -> void:
	player.velocity.y -= player.gravity * _delta
	if Input.is_action_pressed("turn_left"):
		player.rotation.z += player.Vec3Z.y - player.turn_speed #* V_LOOK_SENS
		player.rotation.z = clamp(player.rotation.x, -50, 90)
		player.rotation.y += player.Vec3Z.y + player.turn_speed #* M_LOOK_SENS

	elif Input.is_action_pressed("turn_right"):
		player.rotation.z -= player.Vec3Z.y + player.turn_speed #* V_LOOK_SENS
		player.rotation.z = clamp(player.rotation.x, -50, 90)
		player.rotation.y -= player.Vec3Z.y + player.turn_speed #* M_LOOK_SENS
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_pressed("move_forward"):
		finished.emit(WALKING)
	# elif Input.is_action_pressed("turn_left") or Input.is_action_pressed("turn_right"):
	# 	finished.emit(RUNNING)
