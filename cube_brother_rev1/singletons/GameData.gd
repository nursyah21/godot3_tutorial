extends Node

var audio_play = true
var audio_seek = 0


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		print("i'm quit")
		save_game()

func _ready():
	print('load game')
	load_game()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return 
	save_game.open("user://savegame.save", File.READ)
	while save_game.get_position() < save_game.get_len():
		# Get the saved dictionary from the next line in the save file
		var node_data = parse_json(save_game.get_line())
		audio_play = node_data['audio_play']
		
	save_game.close()

func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var data = {
		"audio_play": audio_play,
	}
	save_game.store_line(to_json(data))
	save_game.close()
