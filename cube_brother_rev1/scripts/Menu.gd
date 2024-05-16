extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$background.visible = true
	pass # Replace with function body.
	




func _on_play_button_down():
	#print("change scene")
	get_tree().change_scene("res://scenes/Level1.tscn")
	
