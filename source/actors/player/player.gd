extends KinematicBody2D
export (float) var speed = 100

func movement(dir):
	move_and_collide(dir * speed * get_physics_process_delta_time())
	
func dominance(