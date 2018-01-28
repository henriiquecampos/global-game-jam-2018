extends Node
onready var init_text = get_node("Panel/P1").get_text()
var p1_score = 0
var p2_score = 0
var seconds = 180
var minutes = seconds/60
onready var time_text = $Panel/Time.get_text()
func _ready():
	set_score("P1", 0)
	set_score("P2", 0)
	
func _process(delta):
	seconds -= delta
	minutes = int(floor(seconds/60))
	$Panel/Time.set_text(time_text.format({"minutes": minutes, "seconds":seconds}))
	
	if seconds <= 0.0:
		var winner 
		if p1_score > p2_score:
			winner = "KEK"
		else:
			winner = "LEL"
		$Winner.pop_up(max(p1_score, p2_score), winner)
func set_score(which, amount):
	if which == "P1":
		p1_score += amount
		get_node("Panel/" + which).set_text(init_text.format({"score":p1_score}))
	else:
		p2_score += amount
		get_node("Panel/" + which).set_text(init_text.format({"score":p2_score}))