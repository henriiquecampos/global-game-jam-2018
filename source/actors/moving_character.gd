extends KinematicBody2D
export (float) var speed = 100

var can_leave = false
var limit_x = 1280
var limit_y = 720

func _ready():
	if get_parent().is_in_group("level"):
		limit_x = get_parent().limits.x
		limit_y = get_parent().limits.y
func movement(dir):
	move_and_collide(dir * speed * get_physics_process_delta_time())
	if not can_leave:
		set_position(Vector2(clamp(position.x, 0 + 8, limit_x - 8), clamp(position.y, 0 + 16, limit_y - 16)))

func _on_body_entered( body ):
	pass

func _on_area_entered( area ):
	pass

func _on_area_exited( area ):
	pass


func _on_body_exited( body ):
	pass
