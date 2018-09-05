extends KinematicBody2D

const GRAVITY =  25 # intensity of the gravity
const UP = Vector2( 0, -1 ) # vector that points in the "up" direction

var motion = Vector2( 0, 0 )

func _handle_sideways_movement():
	
	if Input.is_action_pressed( "ui_right" ):
		motion.x = 200
	elif Input.is_action_pressed( "ui_left" ):
		motion.x = -200
	else:
		motion.x = 0
	
func _allow_jump():
	
	if Input.is_action_just_pressed( "ui_select" ):
	
		motion.y = -500

func _physics_process( delta ):

	motion.y += GRAVITY # constantly apply gravity to player

	_handle_sideways_movement()

	# method specific to Kinematic Body 2D
	var collision_info = move_and_slide( motion, UP ) #um, docs say to pass in delta?
	
	if is_on_floor():
		_allow_jump()
	
