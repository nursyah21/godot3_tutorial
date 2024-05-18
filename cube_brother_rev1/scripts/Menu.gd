extends Node2D

var level1 = preload("res://scenes/Level1.tscn")
export var click: AudioStream
# Called when the node enters the scene tree for the first time.
func _ready():
	if $Menu:
		$Menu/background.visible = true
	




func _on_play_button_down():
	$effect.stream = click
	$effect.play()
	$Menu.queue_free()
	var l1 = level1.instance()
	get_parent().add_child(l1)
	


var music_bus = AudioServer.get_bus_index("Master")
func _on_sound_pressed():
	AudioServer.set_bus_mute(music_bus, ! $Menu/sound.pressed)
