extends KinematicBody2D
export (float) var speed = 100
export (String, "P1", "P2") var player = "P1"

func movement(dir):
	move_and_collide(dir * speed * get_physics_process_delta_time())
	
func dominance(tower):
	tower.set_player(player)

func _on_body_entered( area ):
	if area.is_in_group("tower"):
		dominance(area.get_parent())