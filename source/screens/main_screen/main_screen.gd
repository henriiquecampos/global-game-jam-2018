extends "res://screens/abstract_screen.gd"

onready var bgm_bus = AudioServer.get_bus_index(bgm.get_bus())
#onready var sfx_bus = AudioServer.get_bus_index(sfx.get_bus())

func _ready():
	$VolumeBGM.set_value(AudioServer.get_bus_volume_db(bgm_bus))
#	$VolumeSFX.set_value(AudioServer.get_bus_volume_db(sfx_bus))
	$Menu/Play.grab_focus()

func _on_bgm_value_changed( value ):
	AudioServer.set_bus_volume_db(bgm_bus, value)

func _on_sfx_value_changed( value ):
#	AudioServer.set_bus_volume_db(sfx_bus, value)
	pass

func quit():
	get_tree().quit()
