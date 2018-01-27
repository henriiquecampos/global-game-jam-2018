extends KinematicBody2D
export (float) var speed = 100

func movement(dir):
	move_and_collide(dir * speed * get_physics_process_delta_time())
	
func _on_body_entered( body ):
	pass

func _on_area_entered( area ):
	pass
