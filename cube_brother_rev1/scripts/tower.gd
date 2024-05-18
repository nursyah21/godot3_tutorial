extends Node2D

var bullet = preload("res://scenes/bullet.tscn")
export var tower: Texture
export var bullet_texture: Texture
export var speed = 1
export var effect_slow = false
var enemy = []
var curr_enemy
export var ready = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$head.texture = tower
	$shoot.wait_time = 1/speed
	if ready:
		$head.centered = true
	if $range and ready:
		$range.visible = false

func _physics_process(delta):
	if enemy != [] and ready:
		curr_enemy = enemy[0]
		$head.look_at(curr_enemy.global_position)


func _process(delta):
	pass
		

func _on_sight_area_entered(area):
	if area.is_in_group("enemy"):
		enemy.append(area)


func _on_sight_area_exited(area):
	if area.is_in_group("enemy"):
		enemy.erase(area)


func _on_shoot_timeout():
	if curr_enemy and enemy and curr_enemy == enemy[0]:
		var b = bullet.instance()
		b.texture = bullet_texture
		b.global_position = global_position
		b.target = curr_enemy
		
		if effect_slow:
			b.add_to_group("slow")
		
		
		get_parent().add_child(b)
