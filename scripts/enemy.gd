extends Area2D

var speed = 100
@onready var player: CharacterBody2D = $"../CharacterBody2D"


func _process(delta: float) -> void:
	position += position.direction_to(player.position) * speed * delta
