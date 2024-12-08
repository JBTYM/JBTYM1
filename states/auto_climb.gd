extends PlayerState

var target_walllike:Vector3

func enter(previous_state_path: String, data := {}) -> void:
	target_walllike = player.gs.get_held_walllike()
	player.animation_player.play("walking")
func exit():
	player.animation_player.pause()
	var forwards = -player.basis.z
	player.velocity = forwards * 0
	
func align_with_y(xform:Transform3D, new_y:Vector3):
	var old_z = player.basis.z
	xform.basis.y = new_y
	xform.basis.x = -old_z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform

func physics_update(delta: float) -> void:
	var transform = align_with_y(player.transform, target_walllike)
	player.transform = player.transform.interpolate_with(transform, 0.1)
	var held_floorlike = player.gs.get_held_floorlike()
	var velocity_forwards:Vector3 = -player.basis.z * player.speed * 2
	var velocity_downwards:Vector3 = -player.basis.y * player.gravity * delta
	player.velocity = velocity_downwards + velocity_forwards
	player.move_and_slide()
	var rcd = player.rcd.get_collision_normal()
	
	
	if rcd == target_walllike:
		player.gs.set_held_floorlike(rcd)
		player.transform = align_with_y(player.transform, rcd)
		finished.emit(IDLE)
	elif Input.is_action_pressed("run"):
		finished.emit(RUNNING)
	elif Input.is_action_pressed("climb") and player.rcf.is_colliding():
		finished.emit(CLIMBING)
	#elif not Input.is_action_pressed("move_forward"):
		#finished.emit(IDLE)
	#elif not player.is_on_floor():
		#finished.emit(FALLING)
	# elif Input.is_action_just_pressed("move_forward"):
	# 	finished.emit(JUMPING)
	# elif is_equal_approx(input_direction_x, 0.0):
	# 	finished.emit(IDLE)
