extends Area2D

var speed = 210
var damage = 10
var health = 100
var touching_player := false
@onready var attack: AnimationPlayer = $attack
const BLOODSPLATTER = preload("res://scenes/bloodsplatter.tscn")
@onready var player = get_tree().get_nodes_in_group("player")


func _process(delta: float) -> void:
	position += position.direction_to(player[0].position) * speed * delta
	if health <= 0:
		var inst = BLOODSPLATTER.instantiate()
		get_tree().root.add_child(inst)
		inst.position = position
		player[0].lives += 15
		queue_free()
	if touching_player == false:
		attack.play("RESET")
		attack.play("move")
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		touching_player = true
		attack.play("attack_anim")
		speed = 0
func take_damage(amount):
	health -= amount
	

func _on_attack_animation_finished(anim_name: StringName) -> void:
	if anim_name ==  "attack_anim" and touching_player == true:
		player[0].lives -= damage
		attack.play("attack_anim")
		
		


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
			touching_player = false
			speed = 210
