extends "../moving_character.gd"
export (String, "P1", "P2") var player = "P1"

var interactable = null

func dominance(tower):
	if tower != null:
		$Input.set_physics_process(false)
		tower.set_player(player)
		yield(tower, "captured")
		$Input.set_physics_process(true)
	
func _on_body_entered( body ):
	if body.is_in_group("routers"):
		interactable = body

func _on_body_exited( body ):
	if body.is_in_group("routers"):
		interactable = null