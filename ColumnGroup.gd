extends Area2D

# get access to normal column scene
export (PackedScene) var column

# connect signals
# not available in this script because Area2D does not inherit 
# it. Need to change the node type here
#connect( "has_fully_sunk", self, "_test")


# todo: probs better for full width and just divide as needed huh?
var column_half_width

var columns = []

func create_columns():
	
	var i = 1 # < first column already exists
	
	while i < 15:
		
		var new_column = column.instance()	
		
		add_child( new_column )
		
		new_column.position.x = i *  new_column.brick_width
		
		i += 1

func _ready():
	
	# first step is to add the first brick since one is necessary in order to get the dimensions for the column group
	columns.push_back( column.instance() )	
	
	add_child( columns[0] )

	column_half_width = columns[0].brick_width / 2
	
	position.x = column_half_width # columns are centerd, correct column group pos accordingly


	#create_columns()


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
