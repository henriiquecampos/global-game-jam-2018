extends CanvasLayer

export (PoolStringArray) var texts
var next = false
var current = 0
onready var animations = $Animator.get_animation_list()
	
func _ready():
	
	_next_session(current)
func _process(delta):
	if Input.is_action_just_pressed("P1_ACTION") or Input.is_action_just_pressed("P2_ACTION"):
		if next:
			current += 1
			next = false
			_next_session(current)
		else:
			$Label/Animator.seek($Label/Animator.current_animation.length())
			$Animator.seek($Animator.current_animation.length())

func _next_session(session):
	if session < texts.size():
		$Label.set_text(texts[session])
		$Label/Animator.play("type")
		$Animator.play(animations[session])
	else:
		get_tree().change_scene("res://screens/gameplay/gameplay_screen.tscn")

func _on_animator_finished( anim_name ):
	next = true
