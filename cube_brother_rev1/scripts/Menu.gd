extends Node2D

var level1 = preload("res://scenes/Level1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	if $Menu:
		$Menu/background.visible = true




func _on_play_button_down():
	$effect.stream = load("res://audio/click_001.ogg")
	$effect.play()
	GameData.audio_seek = $backsound.get_playback_position()
	$wait_time.start()


var music_bus = AudioServer.get_bus_index("Master")
func _on_sound_pressed():
	GameData.audio_play = $Menu/sound.pressed
	AudioServer.set_bus_mute(music_bus, ! $Menu/sound.pressed)


func _on_wait_time_timeout():
	get_tree().change_scene("res://scenes/Level1.tscn")	
