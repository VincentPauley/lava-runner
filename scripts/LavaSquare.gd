extends Area2D

onready var sprite = $Sprite

var height
var width

func _ready():
	
	# needed for positioning in row
	height = sprite.texture.get_height() 
	width = sprite.texture.get_width()
