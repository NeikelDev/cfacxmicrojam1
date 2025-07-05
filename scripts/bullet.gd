extends Area2D
var speed = 200
	
@onready var player = get_tree().get_nodes_in_group("player")
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.take_damage(50)
		player[0].lives += 15
		queue_free()
