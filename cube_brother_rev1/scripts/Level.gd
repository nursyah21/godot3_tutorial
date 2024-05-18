extends Node2D

var mob = preload("res://scenes/enemy.tscn")
export var wave_mobs = [1,3,6,10,15,20,30]
export var money = 100
export var price_tower_blue = 100
export var price_tower_pink = 200
export var price_tower_purple = 150
var _money
var instance
var remaining_enemy
var fail = false
var win = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$background.visible = true
	_money = $ui/hud/money
	remaining_enemy = len(wave_mobs)
	print('remaining enemy: '+ str(remaining_enemy))
	$ui/pause/sound.pressed = GameData.audio_play	
	$backsound.play(GameData.audio_seek)
	
var n = 1
var curr = 0
func _on_Timer_timeout():
	if wave_mobs[curr] == n:
		instance = mob.instance()
		instance.set_name("enemy")
		$Path2D.add_child(instance)
		curr += 1
	n+=1
	
	if curr == len(wave_mobs) -1:
		print('last enemy')
		$Timer.stop()

func _on_end_area_entered(area):
	if area.is_in_group("enemy"):
		fail = true
		get_tree().paused = true
		$ui/pause_btn.texture_normal = load("res://assets/pause.png")
		for i in $ui/lose.get_children():
			i.visible = true

func _on_pause_pressed():
	if fail or win:
		return
	$effect.stream = load("res://audio/click_001.ogg")
	$effect.play()
	
	if get_tree().is_paused():
		get_tree().paused = false
		$ui/pause_btn.texture_normal = load("res://assets/pause.png")
		for i in $ui/pause.get_children():
			i.visible = false
	else:
		get_tree().paused = true
		$ui/pause_btn.texture_normal = load("res://assets/play.png")
		for i in $ui/pause.get_children():
			i.visible = true

# this is all new code
var build_mode = false
var build_valid = false
var build_tile
var build_location
var build_type

var last = []
func _process(_delta):
	_money.text = str(money)	
	if money < price_tower_blue:
		$ui/hud/tower_blue.modulate = Color(1,1,1,.2)
	if money < price_tower_pink:
		$ui/hud/tower_pink.modulate = Color(1,1,1,.2)
	if money < price_tower_purple:
		$ui/hud/tower_purple.modulate = Color(1,1,1,.2)
	
	if build_mode:
		update_tower_preview()
	
	if win and ! $ui/win/pause_menu.visible:
		for i in $ui/win.get_children():
			i.visible = true
		
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and build_mode:
		cancel_build_mode()
	if event.is_action_pressed("ui_accept") and build_mode:
		verify_and_build()
		cancel_build_mode()
	
func _on_tower_blue_pressed():	
	if money >= price_tower_blue:
		initiate_build_mode("tower_blue")
	
func _on_tower_pink_pressed():
	if money >= price_tower_pink:
		initiate_build_mode("tower_pink")
	
func _on_tower_purple_pressed():
	if money >= price_tower_purple:
		initiate_build_mode("tower_purple")

func initiate_build_mode(tower):
	$effect.stream = load("res://audio/click_001.ogg")
	$effect.play()
	
	if build_mode:
		cancel_build_mode()
	build_mode = true
	build_type = tower
	$ui.set_tower_preview(tower, get_global_mouse_position())

func update_tower_preview():
	var mouse_pos = get_global_mouse_position()
	var curr_tile = $map/placement.world_to_map(mouse_pos)
	var tile_pos = $map/placement.map_to_world(curr_tile)
	
	if $map/placement.get_cellv(curr_tile) == 0:
		$ui.update_tower_preview(tile_pos, Color(1,1,1))		
		build_location = tile_pos
		build_tile = curr_tile
		build_valid = true
	else:
		$ui.update_tower_preview(tile_pos, Color(1,0,0,1))
		build_valid = false

func cancel_build_mode():
	build_mode = false
	build_valid = false
	if $ui/tower_preview:
		$ui/tower_preview.free()

func verify_and_build():
	if build_valid:
		var new_tower = load("res://scenes/"+build_type+".tscn").instance()
		new_tower.position = build_location
		new_tower.ready = true
		$map/placement.add_child(new_tower)
		$map/placement.set_cellv(build_tile, 1)
		if build_type == 'tower_blue':
			money -= price_tower_blue
		if build_type == 'tower_pink':
			money -= price_tower_pink
		if build_type == 'tower_purple':
			money -= price_tower_purple

var music_bus = AudioServer.get_bus_index("Master")
func _on_sound_pressed():
	AudioServer.set_bus_mute(music_bus, ! $ui/pause/sound.pressed)

func _on_restart_pressed():
	GameData.audio_seek = $backsound.get_playback_position()
	get_tree().paused = false
	var i = get_tree().reload_current_scene()
	print(i)

func _on_next_pressed():
	print('next level')
