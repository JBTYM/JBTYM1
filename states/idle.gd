extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("Batch1/ANIM_spider_idleBase")
	player.velocity = player.basis.z * 0

func physics_update(_delta: float) -> void:
	if Input.is_action_pressed("turn_left"):
		player.rotate(player.gs.get_held_floorlike(), player.turn_speed)
		player.animation_player.play("walking")
		player.animation_player.speed_scale = 2
	elif Input.is_action_pressed("turn_right"):
		player.rotate(player.gs.get_held_floorlike(), -player.turn_speed)
		player.animation_player.play("walking")
		player.animation_player.speed_scale = 2
	if (Input.is_action_just_released("turn_left") or Input.is_action_just_released("turn_right")):
		player.animation_player.speed_scale = 1
		player.animation_player.stop()
		player.animation_player.play("Batch1/ANIM_spider_idleBase")

	player.move_and_slide()

	if not player.rcd.is_colliding():
		finished.emit(FALLING)
	elif Input.is_action_pressed("run"):
		finished.emit(RUNNING)
	elif Input.is_action_pressed("move_forward"):
		finished.emit(WALKING)
	elif Input.is_action_pressed("climb") and (player.rcf.is_colliding()):
		finished.emit(CLIMBING)
	# elif Input.is_action_pressed("turn_left") or Input.is_action_pressed("turn_right"):
	# 	finished.emit(RUNNING)
