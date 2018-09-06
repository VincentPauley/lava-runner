extends Node

onready var timer = $Timer

func _ready():

	timer.start()


func _on_Timer_timeout():
	
	$"/root/SceneChanger".change_scene( "HomeScreen" )
	
	
