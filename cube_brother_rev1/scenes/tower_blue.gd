extends Area2D

var enemy = []
var curr_enemy
var rotation_speed = 50
var bullet = preload("res://scenes/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	if enemy != []:
		curr_enemy = enemy[0]		
		$head.look_at(curr_enemy.global_position)



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
