extends Node2D

var level1 = preload("res://scenes/Level1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if $Menu:
		$Menu/background.visible = true
	




func _on_play_button_down():
	#print("change scene")
	#get_tree().change_scene("res://scenes/Level1.tscn")
	$Menu.queue_free()
	var l1 = level1.instance()
	get_parent().add_child(l1)
	
