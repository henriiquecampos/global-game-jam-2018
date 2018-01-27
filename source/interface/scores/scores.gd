extends Node
onready var init_text = get_node("Panel/P1").get_text()
var p1_score = 0
var p2_score = 0
func _ready():
	set_score("P1", 0)
	set_score("P2", 0)
func set_score(which, amount):
	if which == "P1":
		p1_score += amount
		get_node("Panel/" + which).set_text(init_text.format({"score":p1_score}))
	else:
		p2_score += amount
		get_node("Panel/" + which).set_text(init_text.format({"score":p2_score}))