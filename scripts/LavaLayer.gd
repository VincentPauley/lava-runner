extends Area2D

export (PackedScene) var lava_square


var lava_squares = []

var test = 1

var square_height
var square_width # Column group needs to know the height of the lava layer for sinking purposes, and I don't want to hard-code it

# try a signal to sibling and see what happens I guess

func _insert_lava_square():
	
	var new_square_position = lava_squares.size()
	
	lava_squares.push_back( lava_square.instance() )
	
	add_child( lava_squares[ new_square_position ] )
	
# uses the globally known width to adjust position of each and every lava square
func _correct_square_positions():

	var i = 0
	
	while i < lava_squares.size():
		
		lava_squares[ i ].position.x = square_width * i
		i += 1

func _determine_squares_needed():

	return ceil( get_viewport_rect().size.x / square_width )

func _ready():

	_insert_lava_square()
	
	# set square dimensions globally
	square_height = lava_squares[0].height
	square_width = lava_squares[0].width
	
	# provide top position of lava to nodes that need it
	get_parent().get_node( "ColumnGroup" ).sink_height = get_viewport_rect().size.y - square_height
	get_parent().get_node( "KinematicBody2D" ).lava_height = get_viewport_rect().size.y - square_height
	
	position.y = get_viewport_rect().size.y  - square_height / 2 # take centered origin of block into account when positioning
	
	var squares_needed = _determine_squares_needed()
	
	while lava_squares.size() < squares_needed:
		
		_insert_lava_square()
		
	_correct_square_positions()