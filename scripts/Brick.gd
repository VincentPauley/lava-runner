extends Area2D

var width
var height

onready var sprite = $Sprite

func _ready():

	# initialize width/height props for column's use
	width = sprite.texture.get_width() * scale.x
	height = sprite.texture.get_height() * scale.y