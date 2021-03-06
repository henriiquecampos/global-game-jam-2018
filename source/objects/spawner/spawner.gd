extends Position2D

export (float) var min_spawn_time = 0.5
export (float) var max_spawn_time = 2.0
export (int) var min_amount = 1
export (int) var max_amount = 5

export (String, FILE, "*.tscn") var client_scene

func _ready():
	randomize()
	$Cooldown.connect("timeout", self, "spawn_clients", [int(rand_range(min_amount, max_amount +1))])
	$Cooldown.set_wait_time(rand_range(0.5, 2.0))
	$Cooldown.start()
	
func spawn_clients(amount):
	for i in range(amount):
		$SpawnTime.start()
		yield($SpawnTime, "timeout")
		var s = load(client_scene).instance()
		s.set_position(get_position())
		s.spawner = self
		get_parent().add_child(s)
	$Cooldown.set_wait_time(rand_range(min_spawn_time, max_spawn_time))
	$Cooldown.start()