extends Node

var held_floorlike:=Vector3.DOWN
var held_wallike:=Vector3.DOWN

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_held_floorlike()->Vector3:
	return held_floorlike
func set_held_floorlike(new_held_floorlike:Vector3) -> void:
	held_floorlike = new_held_floorlike
func get_held_walllike()->Vector3:
	return held_wallike
func set_held_walllike(new_held_floorlike:Vector3)->void:
	held_wallike = new_held_floorlike
