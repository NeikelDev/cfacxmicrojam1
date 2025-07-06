extends Area2D
var speed = 200
	
@onready var player = get_tree().get_nodes_in_group("player")
func _physics_process(delta):
	position += transform.x * speed * delta
	if position.x > 260 or position.x < -260:
		queue_free()
	if position.y > 150 or position.y < -150:
		queue_free()
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.take_damage(50)
		queue_free()
	
