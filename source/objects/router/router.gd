extends StaticBody2D

enum states {IDLE, CHARGE}

var state = 0 setget set_state, get_state
export (String, "NONE", "P1", "P2") var player = "NONE" setget set_player, get_player
export(float) var charging_time = 2.0

var strength = 0
signal captured

func set_state(value):
	if !is_inside_tree():
		return
	state = CHARGE
	$Sprite.play("charging")
	$CaptureTime.start()
	yield($CaptureTime, "timeout")
	$Sprite.play("idle")
	emit_signal("captured")
	state = IDLE
	if get_player() == "P1":
		$Particles2D.set_self_modulate(Color("00ffff"))
	else:
		$Particles2D.set_self_modulate(Color("ff00ff"))
	$Tween.interpolate_method($ProgressBar, "set_value", $ProgressBar.get_value(), 100, charging_time, $Tween.TRANS_SINE, $Tween.EASE_IN_OUT)
	$Tween.start()
	
func get_state():
	return(state)
	
func set_player(value):
	if !is_inside_tree():
		return
	if get_state() != CHARGE:
		$ProgressBar.set_value(0)
		player = value
		set_state(CHARGE)

func get_player():
	return(player)

func _on_charge_bar_changed( value ):
	strength = value
