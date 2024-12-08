extends PlayerState

var target_walllike:Vector3
var target_angle:float

func enter(previous_state_path: String, data := {}) -> void:
	target_walllike = player.gs.get_held_walllike()
	var current_floorlike = player.gs.get_held_floorlike()
	var collision_point = player.rcfut.get_collision_normal()
	target_angle  = player.position.angle_to(collision_point)
	print("stupid ", target_angle)
	player.animation_player.play("walking")
func exit():
	player.animation_player.pause()
	var forwards = -player.basis.z
	player.velocity = forwards * 0
	
func align_with_y(xform:Transform3D, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform

func physics_update(delta: float) -> void:
	var is_rotation_positive = target_walllike.y != -0
	var rotation_angle = 0.1 if target_angle >=1 else -0.1
	player.rotate(player.basis.x, rotation_angle)
	
	var held_floorlike = player.gs.get_held_floorlike()
	var velocity_forwards:Vector3 = -player.basis.z * player.speed * 2
	var velocity_downwards:Vector3 = -player.basis.y * player.gravity * delta
	player.velocity = velocity_downwards + velocity_forwards
	player.move_and_slide()
	var rcd = player.rcd.get_collision_normal()
	
	if rcd ==  target_walllike:
		player.gs.set_held_floorlike(rcd)
		player.global_transform = align_with_y(player.global_transform, rcd)
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
