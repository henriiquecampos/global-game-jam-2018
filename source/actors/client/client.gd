extends "../moving_character.gd"

var towers = []
var target
var can_wander = true
var move_dir = Vector2()
var spawner = null

export (SpriteFrames) var var_01
export (SpriteFrames) var var_02
export (SpriteFrames) var var_03
export (SpriteFrames) var var_04

onready var frames = [var_01, var_02, var_03, var_04]
func _ready():
	randomize()
	var s = randi()%frames.size()
	$Sprite.set_sprite_frames(frames[s])
	set_physics_process(false)
	yield($Wander, "timeout")
	set_physics_process(true)
	$Money.connect("timeout", self, "money_timeout")

func money_timeout():
	if target == null:
		return
	$"../Scores".set_score(target.player, 100)

func set_speed(value):
	speed = value

func get_speed():
	return(speed)

func _physics_process(delta):
	if can_wander:
		movement(move_dir)
	
func _on_area_entered(area):
	if area.is_in_group("ranges"):
		towers.append(area.get_parent())
		
func _on_area_exited(area):
	if area.is_in_group("ranges"):
		towers.remove(towers.find(area.get_parent()))

func seek_tower():
	for t in towers:
		if target == null:
			target = t
		else:
			if t.strength > target.strength:
				target = t
	if target.get_player() != "NONE":
		$Money.start()
		return((target.get_global_position() - get_global_position()).normalized())
	else:
		return(wander())
		
func wander():
	var direction = Vector2(rand_range(-50, 50), rand_range(-50, 50))
	return(direction.normalized())
	
func toogle_wander():
	if can_wander:
		#move
		$Wander.set_wait_time(rand_range(0.5, 1.0))
		can_wander = false
		$Sprite.play("idle")
	else:
		#wait
		$Wander.set_wait_time(rand_range(2, 4))
		if towers.size() > 0:
			move_dir = seek_tower()
		else:
			move_dir = wander()
		can_wander = true
		if move_dir.x > 0:
			$Sprite.set_flip_h(false)
		else:
			$Sprite.set_flip_h(true)
		$Sprite.play("walking")

func _on_patience_timeout():
	set_physics_process(false)
	leave_screen()
	
func leave_screen():
	$Sprite.play("walking")
	var t = $Tween
	var dist = (global_position.distance_to(spawner.global_position))
	var time = dist / get_speed()
	t.interpolate_method(self, "set_global_position", get_global_position(), spawner.get_global_position(),
		time * 2, t.TRANS_LINEAR, t.EASE_IN)
	if get_global_position().x > spawner.get_global_position().x:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
	$Shape.set_disabled(true)
	t.start()
	yield(t, "tween_completed")
	queue_free()