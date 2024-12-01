class_name PlayerOLD extends CharacterBody3D
 
enum States {IDLE, RUNNING, MOVING, FALLING, CLIMBING}
var state:States = States.IDLE

@export var FORWARD_SPEED = 1.0
@export var BACK_SPEED = 1.0
@export var TURN_SPEED = 0.05

var RUN_SPEED_IF_PRESSED = 3.0
var RUN_SPEED_IF_NOT_PRESSED = 1.0

var Vec3Z = Vector3.ZERO

#OPTIONAL: These could be used to change sensitivity of either rotating z or y
#var M_LOOK_SENS = 1
#var V_LOOK_SENS = 1

func _physics_process(delta: float) -> void:
	var isRunPressed = Input.is_action_pressed("run")
	var isClimbPressed = Input.is_action_pressed("climb")
	var lastCollision = get_last_slide_collision()
	var isTouchingWall = lastCollision != null
	if is_on_wall():
		print("am on wall!!")
	if isTouchingWall and isClimbPressed:
		
		var gravity = get_gravity()
		gravity.direction_to(lastCollision.get_position())
		print(get_gravity())
	
	if isClimbPressed:
		print("climbing")
		print("lastCollision")
		print(lastCollision)
	var runModifier = RUN_SPEED_IF_PRESSED if isRunPressed else RUN_SPEED_IF_NOT_PRESSED
	if Input.is_action_pressed("move_forward") and Input.is_action_pressed("move_back"):
		velocity.x = 0
		velocity.z = 0

	if Input.is_action_pressed("move_forward"):
		var forwardVector = -Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
		velocity = -forwardVector * FORWARD_SPEED * runModifier
	elif Input.is_action_pressed("move_back"):
		var backwardVector = Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
		velocity = -backwardVector * BACK_SPEED * runModifier
	elif isRunPressed:
		var forwardVector = -Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
		velocity = -forwardVector * FORWARD_SPEED * runModifier	
	#If pressing nothing stop velocity
	else:
		velocity.x = 0
		velocity.z = 0
		
	if (isRunPressed):
		$AnimationPlayer.speed_scale = 6
	else:
		$AnimationPlayer.speed_scale = 1
	
	# IF turn left WHILE moving back, turn right
	if Input.is_action_pressed("turn_left") and Input.is_action_pressed("move_back"):
		rotation.z -= Vec3Z.y + TURN_SPEED #* V_LOOK_SENS
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y -= Vec3Z.y + TURN_SPEED #* M_LOOK_SENS
	
	elif Input.is_action_pressed("turn_left"):
		rotation.z += Vec3Z.y - TURN_SPEED #* V_LOOK_SENS
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y += Vec3Z.y + TURN_SPEED #* M_LOOK_SENS

	# IF turn right WHILE moving back, turn left
	if Input.is_action_pressed("turn_right") and Input.is_action_pressed("move_back"):
		rotation.z += Vec3Z.y - TURN_SPEED #* V_LOOK_SENS
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y += Vec3Z.y + TURN_SPEED #* M_LOOK_SENS
		
	elif Input.is_action_pressed("turn_right"):
		rotation.z -= Vec3Z.y + TURN_SPEED #* V_LOOK_SENS
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y -= Vec3Z.y + TURN_SPEED #* M_LOOK_SENS
	
	move_and_slide()
