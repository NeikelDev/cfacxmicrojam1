extends Node2D
const ENEMY = preload("res://scenes/enemy.tscn")
var enemies = [ENEMY]
@onready var spawner: Node2D = $spawner
@onready var spawner_2: Node2D = $spawner2
@onready var spawner_3: Node2D = $spawner3
@onready var spawner_4: Node2D = $spawner4
@onready var spawner_5: Node2D = $spawner5
@onready var spawner_6: Node2D = $spawner6
@onready var spawner_7: Node2D = $spawner7
@onready var spawner_8: Node2D = $spawner8
@onready var spawner_9: Node2D = $spawner9
@onready var spawn_points := [spawner,spawner_2,spawner_3,spawner_4,spawner_5,spawner_6,spawner_7,spawner_8,spawner_9]


func _on_spawn_timer_timeout() -> void:
	var rand_spawn = randi_range(0,spawn_points.size() - 1)
	var rand_enemy = randi_range(0,enemies.size() - 1)
	 
	var inst = enemies[rand_enemy].instantiate()
	get_tree().root.add_child(inst)
	inst.position = spawn_points[rand_spawn].position
