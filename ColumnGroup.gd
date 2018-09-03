extends Area2D

# get access to normal column scene
export (PackedScene) var column

# connect signals
# not available in this script because Area2D does not inherit 
# it. Need to change the node type here

# NOTE: this is populated from the LavaLayer dyanmically to avoid hard-coding
var sink_height

var sunken_columns = 0

# todo: probs better for full width and just divide as needed huh?
var column_half_width

var columns = []

# 
# Function _add_column
#
# Creates a new column to the right of the last inserted
# one (or on the left side of the screen for the first 
# one).  Takes care of positioning and signal hookup.
#
func _add_column():
	
	var new_column_position = columns.size()
	
	var new_column = column.instance()
	
	columns.push_back( new_column )
	
	add_child( columns[ new_column_position ] )
	
	# adjust position of the column
	new_column.position.x += new_column.brick_width * new_column_position
	
	# hook up sunken signal
	new_column.connect("has_fully_sunk", self, "_test")
	
func _adjust_sink_height():
	
	print( "-- Received the shit" )

func _ready():
	
	_add_column()

	column_half_width = columns[0].brick_width / 2
	
	position.x = column_half_width # columns are centerd, correct column group pos accordingly

	# TODO: have a better way of determining how many to insert (screen width etc.)
	while columns.size() < 4:
		_add_column()

func _test():
	
	sunken_columns += 1
	
	if sunken_columns == columns.size():
		
		# just reload scene for now.
		get_tree().reload_current_scene()
