extends Area2D

export (PackedScene) var brick

signal has_fully_sunk

# dimensional properties
var screen_height
var brick_height
var brick_width

var column_starting_top_pos = 100
var sink_speed

const MAX_SINK_SPEED = 40
const MIN_SINK_SPEED = 20


# this will store all bricks that make up the column
var column_bricks = []

# randomly determine the height of the column within range.


#
# Function: _set_sink_speed()
#
# This creates a random number within range for sink speed based on the 
# class contents and sets it to the appropriate variable
#
func _set_sink_speed():
	
	randomize()
	
	sink_speed = randi()%MAX_SINK_SPEED+MIN_SINK_SPEED

#
# Function: _space_to_fill()
#
# simple function that determines the amount of coordinates necessary to fill in order for the
# column to be full of bricks from starting height to bottom of screen and in the future lava.
#
#
func _space_to_fill():
	
	return screen_height - column_starting_top_pos

#
# Function: _add_remaining_bricks
#
# The required brick count necessary to complete the column is
# provided as an argument, and a simple while loop inserts that
# many bricks to the column.
#
func _add_remaining_bricks( bricksNeeded ):

	var i = 0

	# add all bricks needed to the column
	while i < bricksNeeded:
		
		column_bricks.push_back( brick.instance() )
		i += 1
#
# Function: _reposition_bottom_bricks
#
# by default the top brick is rendered on screen, and in the correct 
# position.  This function adds the remaining instantiations in the 
# array to the scene and repositions them sequentially.
#
func _reposition_bottom_bricks(): # TODO: rename to include instantiation?

	var i = 1 # first brick is already taken care of
	
	while i < column_bricks.size():
		
		# add brick to scene
		add_child( column_bricks[ i ] )
		
		# adjust position accordingly to index and known brick height
		column_bricks[ i ].position.y += brick_height * i + ( brick_height / 2 )
		
		i += 1

#
# Function: _initialize_column
#
# Determines how many bricks are needed for a column and instantiates
# and positions them within the scene
#
func _initialize_column():
	
	# need to add the first brick just to know the height
	column_bricks.push_back( brick.instance() ) 
	
	add_child( column_bricks[0] )

	brick_height = column_bricks[0].height # need this globally for height calculations
	brick_width = column_bricks[0].width
	
	# position with starting height as well as half of brick's height since the position is the center of the brick
	position.y += column_starting_top_pos + brick_height / 2 
	
	# correct for brick's centered position
	column_bricks[0].position.y  += brick_height / 2
	
	var space_remaining = _space_to_fill() - brick_height

	# find remaining bricks necessary
	var bricks_needed = ceil( space_remaining / brick_height )

	_add_remaining_bricks( bricks_needed )

	# add to scene and reposition
	_reposition_bottom_bricks()

func _ready():

	_set_sink_speed()

	# set height so column can figure out how man bricks it needs to be full
	screen_height = get_viewport_rect().size.y
	
	_initialize_column()

func _process(delta):

	var velocity = Vector2(0,0)
	
	velocity.y += sink_speed;
	
	if( position.y > 600 ):
	
		emit_signal("has_fully_sunk")
		queue_free() # no need to keep past it's sinking

	position += velocity * delta	
	
	# need to loop through and put bricks in a row within the column
	# to create a stack based on other position.  Then... movement should
	# be controlled in the pillar, Not the brick itself, bricks should
	# break apart has you step on them.
