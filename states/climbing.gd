extends PlayerState

func align_with_y(xform:Node3D, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform.basis

var old_floorlike:= Vector3.DOWN
var old_forward:= Vector3.FORWARD

func enter(previous_state_path: String, data := {}) -> void:
	old_floorlike = player.gs.get_held_floorlike()
	old_forward = -player.basis.z
	var last_collision = player.rcf.get_collision_normal()
	player.gs.set_held_floorlike(last_collision)
	player.animation_player.play("falling")
	#finished.emit(FALLING)


func physics_update(delta: float) -> void:
	var n = player.gs.get_held_floorlike()
	var xform = align_with_y(player, n)
	player.global_transform = player.global_transform.interpolate_with(xform, 0.01)
	
	if player.rcd.is_colliding():
		print("done climbing")
		finished.emit(FALLING)
