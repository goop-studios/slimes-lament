extends CharacterBody3D


var speed = 5.0
var deceleration = 0.1
var jump_velocity = 4.5
var mouse_sensitivity = 0.005
var mouse_delta = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		# Toggle mouse capture mode
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:	
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		var mouse_x = -mouse_delta.x * mouse_sensitivity
		var mouse_y = -mouse_delta.y * mouse_sensitivity
		
		# Apply the mouse movement to your character or camera.
		rotate_y(mouse_x)
		$Camera3D.rotate_x(mouse_y)
		
		mouse_delta = Vector2.ZERO
	# Add the gravity.
		var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction = (transform.basis * Vector3(input_dir.x,  0, input_dir.y)).normalized()
	
	# Apply gravity
		if not is_on_floor():
			velocity.y -= gravity * delta
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = jump_velocity
	# Apply movement
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		# Decelerate when no input is given
	velocity.y = move_toward(velocity.y,  0.0, deceleration)
	velocity.x = move_toward(velocity.x,  0.0, deceleration)
	velocity.z = move_toward(velocity.z,  0.0, deceleration)
	
func _input(event):
	if event is InputEventMouseMotion:
		mouse_delta = event.relative

			
		
