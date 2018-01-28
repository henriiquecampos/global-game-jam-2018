extends Control
export (String, FILE, "*.tscn") var screen_path

func _ready():
	$SFX.set_stream(load("res://interface/finished.ogg"))
	$SFX.play()
	var tw = $Tween
	var tm = $Timer
	var tn = $TransLayer/Transition
	tw.interpolate_property(tn, "rect_position", tn.get_position(), tn.get_position() - Vector2(1280,0),
		1.0, tw.TRANS_LINEAR, tw.EASE_IN)
	tw.start()
	yield(tw, "tween_completed")

func next_screen(next_screen = screen_path):
	var tw = $Tween
	var tm = $Timer
	var tn = $TransLayer/Transition
	tw.interpolate_property(tn, "rect_position", tn.get_position(), tn.get_position() + Vector2(1280,0),
		0.5, tw.TRANS_LINEAR, tw.EASE_OUT)
	tw.start()
	yield(tw, "tween_completed")
	$SFX.set_stream(load("res://interface/loading.ogg"))
	$SFX.play()
	tm.start()
	yield(tm, "timeout")
	get_tree().change_scene(next_screen)