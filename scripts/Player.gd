extends KinematicBody2D

const GRAVITY =  30 # intensity of the gravity
const UP = Vector2( 0, -1 ) # vector that points in the "up" direction

const SIDEWAYS_SPEED = 300 # left/right top speed for character

# TODO: for the character, would be cool to have acceleration left/right

onready var Sprite = $Sprite
onready var camera = $Camera

var motion = Vector2( 0, 0 )

var lava_height = get_viewport_rect().size.y # NOTE: actually populated via the LavaLayer script
var character_bottom

#
# Function: _set_camera_constraints()
#
# Player can't go below the lava or to the left of
# start, so set camera constraints to reflect that.
#
func _set_camera_constraints():
	
	# set limit for camera dimensions
	camera.limit_bottom = get_viewport_rect().size.y
	camera.limit_left = 0

func _ready():
	
	_set_camera_constraints()

# Function: _handle_sideways_movement()
#
# listens and reacts to player input to control
# sideways movement of the character
#
func _handle_sideways_movement():
	
	if Input.is_action_pressed( "ui_right" ):
		motion.x = SIDEWAYS_SPEED
	elif Input.is_action_pressed( "ui_left" ):
		motion.x = -SIDEWAYS_SPEED
	else:
		motion.x = 0
	
func _allow_jump():
	
	if Input.is_action_just_pressed( "ui_select" ):
	
		motion.y = -800

#
# Function: _check_player_dead
#
# Just a check to see if player has made contact with the 
# lava and game-over state should result.
#
func _check_player_dead():
	
	if character_bottom > lava_height:
		
		# character is in lava so game is over, change the scene
		$"/root/SceneChanger".change_scene( "GameOverScreen" )

func _physics_process( delta ):

	character_bottom = position.y + Sprite.texture.get_height() / 2

	_check_player_dead()

	motion.y += GRAVITY # constantly apply gravity to player

	_handle_sideways_movement()

	# method specific to Kinematic Body 2D
	var collision_info = move_and_slide( motion, UP ) #um, docs say to pass in delta?
	
	if is_on_floor():
		_allow_jump()
	
