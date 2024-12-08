# Character that moves and jumps.
class_name Player extends CharacterBody3D

@export var Vec3Z = Vector3.ZERO
## Horizontal speed in pixels per second.
@export var speed := 1.0
@export var run_modifier := 5.0
@export var turn_speed = 0.05
## Vertical acceleration in pixel per second squared.
@export var gravity := 10.0
## Vertical speed applied when jumping.
@export var jump_impulse := 10.0

@export var glide_max_speed := 10.0
@export var glide_acceleration := 10.0
@export var glide_gravity := 10.0
@export var glide_jump_impulse := 10.0

@onready var fsm:Node= $StateMachine
@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var gs:Node = $gravity_stuff
@onready var rcf:RayCast3D = $RayCastForward
@onready var rcd:RayCast3D = $RayCastDownward
@onready var rcfut:RayCast3D = $RayCastFuture
