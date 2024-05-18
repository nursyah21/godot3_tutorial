extends Area2D

var enemy = []
var curr_enemy
var rotation_speed = 50
var bullet = preload("res://scenes/bullet.tscn")
var building = true
var can_place = false
var place = []

func _physics_process(_delta):
	if !building:
		#$range.visible = false
		if enemy != [] and !$range.visible:
			curr_enemy = enemy[0]		
			$head.look_at(curr_enemy.global_position)
""""	
	else:
		$range.visible = true
		global_position = get_global_mouse_position()
		if can_place == true:
			$range.modulate = Color(0,0,0)
			if Input.is_action_just_pressed("click"):
				building = false
				
		else:
			$range.modulate =  Color(1, 1, 1)
"""


func _on_sight_area_entered(area):
	if area.is_in_group("enemy"):
		enemy.append(area)


func _on_sight_area_exited(area):
	if area.is_in_group("enemy"):
		enemy.erase(area)


func _on_shoot_timeout():
	if curr_enemy and enemy and curr_enemy == enemy[0]:
		var b = bullet.instance()
		b.global_position = global_position
		b.target = curr_enemy
		get_parent().add_child(b)


func _on_placement_area_entered(area):
	if area.is_in_group("place"):
		if building == true:
			place.append(area)
			can_place = true


func _on_placement_area_exited(area):
	if area.is_in_group("place"):
		if building == true:
			place.erase(area)
			can_place = true
