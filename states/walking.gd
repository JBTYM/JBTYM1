extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("walking")
func exit():
	player.animation_player.pause()
	var forwards = -player.basis.z
	player.velocity = forwards * 0

func physics_update(delta: float) -> void:
	var forwards = -player.basis.z
	player.velocity = forwards * player.speed 
	if Input.is_action_pressed("turn_left"):
		player.rotate(player.gs.get_held_floorlike(), player.turn_speed)
	elif Input.is_action_pressed("turn_right"):
		player.rotate(player.gs.get_held_floorlike(), -player.turn_speed)
	
	var future = player.rcfut.get_collision_normal()
	var down = player.rcd.get_collision_normal()
	player.move_and_slide()
	
	if Input.is_action_pressed("run"):
		finished.emit(RUNNING)
	elif player.rcf.is_colliding():
		player.gs.set_held_walllike(player.rcf.get_collision_normal())
		finished.emit(AUTOCLIMBING)
	elif player.rcd.get_collision_normal() !=  player.rcfut.get_collision_normal():
		player.gs.set_held_walllike(player.rcfut.get_collision_normal())
		finished.emit(AUTOCLIMBING)
	elif Input.is_action_pressed("climb") and player.rcf.is_colliding():
		finished.emit(CLIMBING)
	elif not Input.is_action_pressed("move_forward"):
		finished.emit(IDLE)
	#elif not player.is_on_floor():
		#finished.emit(FALLING)
	# elif Input.is_action_just_pressed("move_forward"):
	# 	finished.emit(JUMPING)
	# elif is_equal_approx(input_direction_x, 0.0):
	# 	finished.emit(IDLE)
