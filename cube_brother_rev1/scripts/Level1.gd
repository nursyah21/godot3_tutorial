extends Node2D

var mob = preload("res://scenes/enemy.tscn")
var wave_mobs = [1,3,6,10,15,20,30]

var instance

# Called when the node enters the scene tree for the first time.
func _ready():
	$background.visible = true
	
var n = 1
var curr = 0
var last_enemy = false
func _on_Timer_timeout():
	if wave_mobs[curr] == n:
		instance = mob.instance()
		$Path2D.add_child(instance)
		curr += 1
	n+=1
	
	if curr == len(wave_mobs) -1 and !last_enemy:
		print("last enemy")
		last_enemy = true


func _on_end_area_entered(area):
	if area.is_in_group("enemy"):
		print("fail")
