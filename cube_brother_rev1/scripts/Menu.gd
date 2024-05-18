extends Node2D

var level1 = preload("res://scenes/Level1.tscn")
var music_bus = AudioServer.get_bus_index("Master")

var hold_time = 0.5  # Time in seconds to consider a hold (adjust as needed)
var timer = Timer.new()
var is_holding = false

func _ready():
	if $Menu:
		$Menu/background.visible = true
	print(GameData.audio_play)
	$Menu/sound.pressed = GameData.audio_play
	AudioServer.set_bus_mute(music_bus, ! GameData.audio_play)
	add_child(timer)  # Add the timer to the scene


"""
#percobaan mouse
var first_touch_pos = Vector2()  # Stores position of first tap
var first_touch_time = 0.0  # Stores timestamp of first tap
var is_first_tap = true  # Flag to track first or second tap
var double_click_threshold = 200  # Time threshold in milliseconds
var double_click_distance = 50  # Distance threshold in pixels

func _unhandled_input(event):
	#$Label.text = str(event.is_pressed())
	if event is InputEventScreenTouch:
		$Label.text = "mobile touch"
		if event.is_pressed():
			$hold.start()
			is_holding = true
			if is_first_tap:
				first_touch_pos = event.position
				first_touch_time = OS.get_ticks_msec()  # Use milliseconds for better precision
				is_first_tap = false
			else:
				if (OS.get_ticks_msec() - first_touch_time) <= double_click_threshold and (event.position - first_touch_pos).length() <= double_click_distance:
					print("Double click detected!")
					$Label.text = "Double click detected"
					# Perform double click actions here
					is_first_tap = true  # Reset for next click
		else:
			is_holding = false
			$Label.text = "test"		
		
func _on_hold_timeout():
	if is_holding:
		$Label.text = "mobile touch hold"
		is_holding = false
"""

func _on_play_button_down():
	$effect.stream = load("res://audio/click_001.ogg")
	$effect.play()
	GameData.audio_seek = $backsound.get_playback_position()
	$wait_time.start()



func _on_sound_pressed():
	GameData.audio_play = $Menu/sound.pressed
	AudioServer.set_bus_mute(music_bus, ! $Menu/sound.pressed)


func _on_wait_time_timeout():
	return get_tree().change_scene("res://scenes/Level1.tscn")


