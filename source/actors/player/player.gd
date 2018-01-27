extends "../moving_character.gd"
export (String, "P1", "P2") var player = "P1"

func dominance(tower):
	tower.set_player(player)