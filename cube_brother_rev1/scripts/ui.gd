extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func set_tower_preview(tower_type, mouse_position):
	var tower = load("res://scenes/"+tower_type+".tscn").instance()
	tower.set_name("drag_tower")

	var control = Control.new()
	control.add_child(tower, true)
	control.rect_position = mouse_position
	control.set_name("tower_preview")
	add_child(control, true)
	move_child($tower_preview, 0)
	

func update_tower_preview(new_pos, col):
	$tower_preview.rect_position = new_pos
	#$tower_preview.set_global_position(new_pos)
	$tower_preview.modulate = col
	
