extends "../moving_character.gd"

var money = 100 setget set_money
var towers = []
var target
var can_wander = true
var move_dir = Vector2()
var spawner = null
func set_money(value):
	money -= value
	
func set_speed(value):
	speed = value

func get_speed():
	return(speed)

func money_timeout():
	set_money(1)
	
func _ready():
	print(get_speed())
	$Money.connect("timeout", self, "money_timeout")

func _physics_process(delta):
	if can_wander:
		movement(move_dir)
	else:
#		seek_tower()
		pass
	
func _on_area_entered(area):
	if area.is_in_group("tower"):
		towers.append(area.get_parent())
		
func _on_area_exited(area):
	if area.is_in_group("tower"):
		towers.remove(area.find(area.get_parent()))

func seek_tower():
	if towers.size() > 0:
		$Wander.stop()
		for t in towers:
			if target == null:
				target = t
			else:
				if t.power > target.power:
					target = t
		movement((get_global_position() - target.get_global_position()).normalized())
					
	else:
		$Wander.start()
		
func wander():
	var direction = Vector2(rand_range(-50, 50), rand_range(-50, 50))
	return(direction.normalized())
	
func toogle_wander():
	if can_wander:
		#move
		$Wander.set_wait_time(rand_range(0.5, 1.0))
		can_wander = false
	else:
		#wait
		$Wander.set_wait_time(rand_range(2, 4))
		move_dir = wander()
		can_wander = true

func _on_patience_timeout():
	set_physics_process(false)
	leave_screen()
	
func leave_screen():
	print("leaving")
	var t = $Tween
	var dist = (global_position.distance_to(spawner.global_position))
	var time = dist / get_speed()
	print(time)
	t.interpolate_method(self, "set_global_position", get_global_position(), spawner.get_global_position(),
		time, t.TRANS_LINEAR, t.EASE_IN)
	$Shape.set_disabled(true)
	t.start()
	yield(t, "tween_completed")
	queue_free()