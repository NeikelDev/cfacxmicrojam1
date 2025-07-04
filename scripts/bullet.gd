extends Area2D
var speed = 1500

func _physics_process(delta):
	position += transform.x * speed * delta



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		queue_free()
