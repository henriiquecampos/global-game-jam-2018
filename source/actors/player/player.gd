extends "../moving_character.gd"
export (String, "P1", "P2") var player = "P1"

var interactable = null

func dominance(tower):
	if tower != null:
		$Input.set_physics_process(false)
		$Input.set_process_input(false)
		tower.set_player(player)
		$Sprite.play("hacking")
		yield(tower, "captured")
		$Sprite.play("idle")
		$Input.set_physics_process(true)
		$Input.set_process_input(true)
	
func _on_body_entered( body ):
	if body.is_in_group("routers"):
		interactable = body

func _on_body_exited( body ):
	if body.is_in_group("routers"):
		interactable = null