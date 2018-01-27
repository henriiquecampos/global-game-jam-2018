extends StaticBody2D

enum states {IDLE, CHARGE}
enum players {NONE, P1, P2}

var state = 0 setget set_state, get_state
var player = NONE setget set_player, get_player
export(float) var charging_time = 2.0

signal captured

func set_state(value):
	state = CHARGE
	$Sprite.play("charging")
	$CaptureTime.start()
	yield($CaptureTime, "timeout")
	$Sprite.play("idle")
	emit_signal("captured")
	state = IDLE
	$Tween.interpolate_method($ProgressBar, "set_value", $ProgressBar.get_value(), 100, charging_time, $Tween.TRANS_SINE, $Tween.EASE_IN_OUT)
	$Tween.start()
	
func get_state():
	return(state)
	
func set_player(value):
	if get_state() != CHARGE:
		player = value
		set_state(CHARGE)

func get_player():
	return(player)