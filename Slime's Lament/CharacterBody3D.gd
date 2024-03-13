extends CharacterBody3D

# Movement variables
@export var speed: float = 10
@export var turnSpeed: float = 0.005
@export var pitchSpeed: float = 0.005
@export var minPitch: float = -80.0
@export var maxPitch: float = 80.0
@export var jump_force = 20
@export var gravity = -50

# Input actions
var move_forward = "move_forward"
var move_backward = "move_backward"
var move_left = "move_left"
var move_right = "move_right"
var jump = "jump"

var camera = null

func _ready():
	# Ensure the input actions are defined in the project settings
	#InputMap.add_action(move_forward)
	#InputMap.add_action(move_backward)
	#InputMap.add_action(move_left)
	#InputMap.add_action(move_right)
	#InputMap.add_action(jump)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera = get_node("CameraPivot")
	pass

func toggle_mouse_capture():
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta):
	# Reset the velocity
	pass

	# Horizontal movement
	var move_direction = Vector3()
	if Input.is_action_pressed(move_forward):
		#print("w")
		move_direction -= transform.basis.z
	if Input.is_action_pressed(move_backward):
		#print("s")
		move_direction += transform.basis.z
	if Input.is_action_pressed(move_left):
		#print("a")
		move_direction -= transform.basis.x
	if Input.is_action_pressed(move_right):
		#print("d")
		move_direction += transform.basis.x

	# Normalize the move direction vector to ensure consistent speed
	move_direction = move_direction.normalized() * speed

	# Apply movement
	velocity.x = move_direction.x 
	velocity.z = move_direction.z 
	velocity.y += gravity * delta

	# Jumping
	if Input.is_action_just_pressed(jump) and is_on_floor():
		velocity.y = jump_force
		
	move_and_slide()
	#move_and_collide()
	
func _input(event):
	if event is InputEventMouseMotion:
		var delta = event.relative
		var yRotation = delta.x * -turnSpeed
		var xRotation = delta.y * -pitchSpeed
		
		# Calculate the new pitch angle
		var newPitchAngle = camera.rotation_degrees.x + xRotation
		
		# Clamp the pitch angle
		var clampedPitchAngle = clamp(newPitchAngle, minPitch, maxPitch)
		
		# Apply the clamped pitch angle
		camera.rotation_degrees.x = clampedPitchAngle
		
		# Apply the y-axis rotation
		rotate_y(yRotation)
		camera.rotate_x(xRotation)
	
	# Check for the Escape key press to toggle mouse capture
	if event.is_action_pressed("ui_cancel"):
		toggle_mouse_capture()

	
