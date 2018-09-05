extends KinematicBody2D

const GRAVITY =  2 # intensity of the gravity
const UP = Vector2( 0, -1 ) # vector that points in the "up" direction

var motion = Vector2( 0, 0 )

func _physics_process( delta ):
	
	motion.y += GRAVITY # constantly apply gravity to player
	
	
			 # method specific to Kinematic Body 2D
	var collision_info = move_and_collide( motion * delta ) #um, docs say to pass in delta?
	
	

