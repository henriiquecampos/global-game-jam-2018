extends Node

onready var parent = get_parent()
var dir = Vector2()
onready var player = parent.player

var device = 0

func _ready():
	if player == "P2":
		device = 1
	else:
		device = 0
func _physics_process(delta):
	dir = Vector2(Input.get_joy_axis(device,0), Input.get_joy_axis(device,1))
	parent.movement(dir)
	
	if Input.is_action_just_pressed(parent.player + "_RIGHT"):
		$"../Sprite".set_flip_h(false)
	elif Input.is_action_just_pressed(parent.player + "_LEFT"):
		$"../Sprite".set_flip_h(true)
	if Input.is_action_just_pressed(parent.player + "_ACTION"):
		parent.dominance(parent.interactable)
		
func _input(event):
	if event.is_action_type():
		if abs(Input.get_joy_axis(device,1)) >= 0.1 or abs(Input.get_joy_axis(device,0)) >= 0.1:
			$"../Sprite".play("walking")
		else:
			$"../Sprite".play("idle")
		print(Input.get_joy_axis(0,1))
		print(Input.get_joy_axis(0,0))