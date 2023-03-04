extends Node

export (PackedScene) var mob_scene = preload("res://Mob.tscn") # ress culd be omited if the file is located in the same folder

func _ready():
	randomize()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UI/Retry.visible:
			get_tree().reload_current_scene()

func _on_MobTimer_timeout():
	var mob = mob_scene.instance()
	
	var mob_spawn_location = $SpawnPath/SpawnPathLocation
	mob_spawn_location.unit_offset = randf()
	
	var player_position = $Player.transform.origin
	
	add_child(mob)
	mob.initialize(mob_spawn_location.translation, player_position)
	mob.connect("squashed", $UI/ScoreLabel, "_on_Mob_squashed")
	

func _on_Player_hit():
	$MobTimer.stop()
	$UI/Retry.show()
