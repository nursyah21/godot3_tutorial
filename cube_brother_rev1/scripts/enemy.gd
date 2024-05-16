extends PathFollow2D


export var health = 4
export var speed = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset += speed * delta
	if unit_offset == 1:
		#print("delete enemy")
		queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet"):
		area.queue_free()
		health -= 1
		if health <= 0:
			#get_parent().get_parent().money += 10
			queue_free()
