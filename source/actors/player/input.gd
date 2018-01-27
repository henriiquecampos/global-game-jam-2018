extends Node

onready var parent = get_parent()
export (String, "P1", "P2") var player = "P1"

func _physics_process(delta):
	if Input.is_action_pressed(player + "_UP"):
		parent.movement(Vector2(0, -1))
	elif Input.is_action_pressed(player + "_DOWN"):
		parent.movement(Vector2(0, 1))
	if Input.is_action_pressed(player + "_RIGHT"):
		parent.movement(Vector2(1, 0))
	elif Input.is_action_pressed(player + "_LEFT"):
		parent.movement(Vector2(-1, 0))