extends "../moving_character.gd"

var money = 100 setget set_money
var towers = []
var target
var can_wander = true
var move_dir = Vector2()
func set_money(value):
	money -= value
	
func money_timeout():
	set_money(1)
	
func _ready():
	$Money.connect("timeout", self, "money_timeout")

func _physics_process(delta):
	if can_wander:
		movement(move_dir)
	else:
		seek_tower()
	
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
		$Wander.set_wait_time(0.5)
		can_wander = false
	else:
		#wait
		$Wander.set_wait_time(rand_range(2, 4))
		move_dir = wander()
		can_wander = true