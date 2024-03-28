extends CharacterBody3D

# Enemy properties
@export var speed = 50.0
@export var attack_range = 2.0
@export var attack_delay = 0.7
@export var turn_speed = 1.0
var attack_timer: Timer = null
var gravity = -50

# Reference to the player
@onready var player: Player =  %Game3D/CharacterBody3D

func _ready():
	# Initialize the attack timer
	attack_timer = Timer.new()
	attack_timer.set_one_shot(false)
	attack_timer.set_wait_time(attack_delay)
	add_child(attack_timer)
	attack_timer.timeout.connect(_on_attack_timer_timeout)

func _process(delta):
	# Check if the player is within the attack range
	if player == null:
		return
	velocity.y += gravity * delta
	var direction: Vector3
	if player.position:
		direction = (player.position - position).normalized()
	var angle:float = (-basis.z).signed_angle_to(direction, Vector3.UP)
	var turn_speed_eval = turn_speed * sign(angle) * delta
	rotate_y(turn_speed_eval)


	if player and position.distance_to(player.position) <= attack_range:
		# Start the attack timer
		#print("player in range")
		if attack_timer.is_stopped():
			attack_timer.start()
	else:
		attack_timer.stop()
		# Move towards the player
		velocity = direction * speed*delta
		#print("skel vel: ", velocity, ", angle: ", angle)
		move_and_slide()

func _on_attack_timer_timeout():
	if player == null:
		return
	# Attack the player
	print("Attacking player!")
	if player.health > 0:
		player.take_damage(1.0)
	# Implement your attack logic here
