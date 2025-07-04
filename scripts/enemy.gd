extends Area2D

var speed = 100
var damage = 10
@onready var player: CharacterBody2D = $"../CharacterBody2D"


func _process(delta: float) -> void:
	position += position.direction_to(player.position) * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.lives -= damage
