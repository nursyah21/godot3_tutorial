extends KinematicBody2D

#var motion = Vector2()
export var speed = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	var motion = Vector2()
	var Player = get_parent().get_node("Player")
	
	motion += (Vector2(Player.position) - position)
	look_at(Player.position)
	
	motion = motion.normalized() * speed
	move_and_collide(motion)

	


func _on_Area2D_body_entered(body):
	if "Bullet" in body.name:
		queue_free()
