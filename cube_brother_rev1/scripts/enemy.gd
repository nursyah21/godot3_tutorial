extends PathFollow2D


export var health = 4
export var speed = 10
var old_speed

func _ready():
	old_speed = speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset += speed * delta
	if unit_offset == 1:
		#print("delete enemy")
		queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet"):
		speed /= 2
		$Area2D/Sprite.modulate = Color(1,1,1,.7)
		
	if area.is_in_group("bullet"):
		area.queue_free()
		health -= 1
		if health <= 0:
			#get_parent().get_parent().money += 10
			queue_free()


func _on_Timer_timeout():
	speed = old_speed
	$Area2D/Sprite.modulate = Color(1,1,1)
