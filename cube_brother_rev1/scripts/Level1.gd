extends Node2D

var mob = preload("res://scenes/enemy.tscn")
var tower_blue = preload("res://scenes/tower_blue.tscn")
var wave_mobs = [1,3,6,10,15,20,30]

var instance
var building = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$background.visible = true
	
var n = 1
var curr = 0
var last_enemy = false

func tower_built(place):
	building = false
	instance = tower_blue.instance()
	place.add_child(instance)
	#money -= 25

func _on_Timer_timeout():
	if wave_mobs[curr] == n:
		instance = mob.instance()
		$Path2D.add_child(instance)
		curr += 1
	n+=1
	
	if curr == len(wave_mobs) -1 and !last_enemy:
		print("last enemy")
		last_enemy = true
		$Timer.stop()


func _on_end_area_entered(area):
	if area.is_in_group("enemy"):
		print("fail")

"""
func _on_tower_blue_pressed():
	if building == false:
		instance = tower_blue.instance()
		add_child(instance)
		building = true
"""

# this is all new code
var build_mode = false
var build_valid = false
var build_tile
var build_location
var build_type

func _process(delta):
	if build_mode:
		update_tower_preview()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and build_mode:
		cancel_build_mode()
	if event.is_action_pressed("ui_accept") and build_mode:
		verify_and_build()
		cancel_build_mode()
		
	
func _on_tower_blue_pressed():
	initiate_build_mode("tower_blue")
	
func _on_tower_pink_pressed():
	initiate_build_mode("tower_pink")

func initiate_build_mode(tower):
	build_mode = true
	build_type = tower
	print(get_global_mouse_position())
	$ui.set_tower_preview(tower, get_global_mouse_position())

func update_tower_preview():
	var mouse_pos = get_global_mouse_position()
	var curr_tile = $map/placement.world_to_map(mouse_pos)
	var tile_pos = $map/placement.map_to_world(curr_tile)
	
	if $map/placement.get_cellv(curr_tile) == 0:
		$ui.update_tower_preview(tile_pos, Color(1,1,1))
		build_valid = true
		build_location = tile_pos
		build_tile = curr_tile
	else:
		$ui.update_tower_preview(tile_pos, Color(1,1,1,.3))
		build_valid = false

func cancel_build_mode():
	build_mode = false
	build_valid = false
	if $ui/tower_preview:
		$ui/tower_preview.queue_free()

func verify_and_build():
	if build_valid:
		var new_tower = load("res://scenes/"+build_type+".tscn").instance()
		new_tower.position = build_location
		new_tower.ready = true
		$map/placement.add_child(new_tower)
		$map/placement.set_cellv(build_tile, 1)





