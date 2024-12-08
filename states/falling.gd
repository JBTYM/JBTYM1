extends PlayerState

var player_up: = Vector3.UP

func enter(previous_state_path: String, data := {}) -> void:
	player_up = -player.basis.y
	player.animation_player.play("falling")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("turn_left", "turn_right")
	player.velocity -= -player_up * player.gravity * delta
	player.move_and_slide()
	if player.rcd.is_colliding():
		var last_new_collision = player.rcd.get_collision_normal()
		player.gs.set_held_floorlike(last_new_collision)
		finished.emit(IDLE)
		#else:
			#finished.emit(RUNNING)
