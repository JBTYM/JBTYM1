extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("falling")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("turn_", "turn_right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if player.is_on_floor():
		if is_equal_approx(input_direction_x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)