extends CharacterBody3D
class_name Player

@onready var camera_pivot: Node3D = $CameraPivot
@onready var visuals = $visuals

# Movement variables
var speed := 3.0
@export var health: float = 100
@export var sens_horizontal: float = 0.5
@export var sens_vertical: float = 0.5
@export var jump_force = 20.0
@export var gravity = -50.0
@export var walking_speed = 3.0
@export var running_speed = 20.0
@export var maxPitch: float = 170
@export var minPitch: float = 1

# Input actions
var move_forward = "move_forward"
var move_backward = "move_backward"
var move_left = "move_left"
var move_right = "move_right"
var jump = "jump"

# Mouse capture toggled states
var allow_camera_rotation = true

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func toggle_mouse_capture():
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		allow_camera_rotation = true
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		allow_camera_rotation = false

# Running/walking
func _physics_process(delta):
	
	if Input.is_action_pressed("run"):
		speed = running_speed
	else:
		speed = walking_speed
	
	# Horizontal movement
	var move_direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		move_direction -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		move_direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		move_direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		move_direction += transform.basis.x

	# Normalize the move direction vector to ensure consistent speed
	move_direction = move_direction.normalized() * speed

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	# Apply movement
	velocity.x = move_direction.x
	velocity.z = move_direction.z
	velocity.y += gravity * delta
	
	var lookat = global_position + move_direction
	if (visuals.global_position.distance_to(lookat) > 0.1):
		visuals.look_at(lookat)
	
	move_and_slide()
	
	# Camera rotation + don't spin'o'nator
func _input(event):
	if event is InputEventMouseMotion and allow_camera_rotation:
		rotate_y(deg_to_rad( - event.relative.x * sens_horizontal))
		visuals.rotate_y(deg_to_rad(event.relative.x * sens_horizontal))
		camera_pivot.rotate_x(deg_to_rad( - event.relative.y * sens_vertical))
		if camera_pivot.rotation_degrees.x > maxPitch:
			camera_pivot.rotation_degrees.x = maxPitch
		if camera_pivot.rotation_degrees.x < minPitch:
			camera_pivot.rotation_degrees.x = minPitch
	
	# Check for the Escape key press to toggle mouse capture
	if event.is_action_pressed("open_UI"):
		toggle_mouse_capture()

func take_damage(dmg: float):
	print("player took ", dmg, " damage")
	health -= dmg
	if health <= 0:
		print("player died")
		queue_free()
