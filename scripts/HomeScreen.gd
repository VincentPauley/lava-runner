extends Node

# start game scene on "Start" button pressed
func _on_Start_pressed():

	$"/root/SceneChanger".change_scene( "Game" )
