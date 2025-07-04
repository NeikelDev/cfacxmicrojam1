extends CharacterBody2D

@export var movement_speed = 200
var character_direction : Vector2
var mouse_pos : Vector2
@onready var arm_1: Node2D = $arm_1
@onready var arm_2: Node2D = $arm_2
@onready var barrel_end: Node2D = $arm_1/barrel_end


@onready var label: Label = $"../HUD/Control/Label"

var lives := 666.0
const BULLET = preload("res://scenes/bullet.tscn")
func _physics_process(delta):
	character_direction.x = Input.get_axis("left", "right")
	character_direction.y = Input.get_axis("up", "down")
	character_direction = character_direction.normalized()
	
	#flip
	if character_direction.x > 0 : $Sprite2D.flip_h = true
	elif character_direction.x < 0 : $Sprite2D.flip_h = false
	
	if character_direction:
		velocity = character_direction * movement_speed
		lives -= 15 * delta
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
	
	
	move_and_slide()
	

func _process(delta: float) -> void:
	label.text = "lives: " + str(round(lives))
	rotate_towards_mouse()
	if Input.is_action_just_pressed("mouse_left"):
		spawn_bullets()
		lives = lives - 5
func rotate_towards_mouse():
		mouse_pos = get_global_mouse_position()
		arm_1.look_at(mouse_pos)
func spawn_bullets():
	var inst = BULLET.instantiate()
	get_tree().root.add_child(inst)
	inst.global_position = barrel_end.global_position
	inst.global_rotation = barrel_end.global_rotation
