extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.speed_scale = player.run_modifier
	player.animation_player.play("walking")

func exit():
	player.animation_player.speed_scale = 1
	player.animation_player.pause()
	player.velocity = player.basis.y * 0
	
func physics_update(delta: float) -> void:
	var forwards = -player.basis.z
	player.velocity = forwards * player.speed * player.run_modifier
	if Input.is_action_pressed("turn_left"):
		player.rotate(player.gs.get_held_floorlike(), player.turn_speed)
	elif Input.is_action_pressed("turn_right"):
		player.rotate(player.gs.get_held_floorlike(), -player.turn_speed)
		
	player.move_and_slide()

	if not Input.is_action_pressed("run"):
		finished.emit(IDLE)
	elif not player.rcd.is_colliding():
		finished.emit(FALLING)
	elif Input.is_action_pressed("climb") and player.rcf.is_colliding():
		finished.emit(CLIMBING)
	#elif not player.is_on_floor():
		#finished.emit(FALLING)
	# elif Input.is_action_just_pressed("move_forward"):
	# 	finished.emit(JUMPING)
	# elif is_equal_approx(input_direction_x, 0.0):
	# 	finished.emit(IDLE)
