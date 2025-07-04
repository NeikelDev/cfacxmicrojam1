extends CharacterBody2D

@export var movement_speed = 200
var character_direction : Vector2
var mouse_pos : Vector2
@onready var arm_1: Node2D = $arm_1
@onready var barrel_end: Node2D = $arm_1/barrel_end
@onready var moving_anim: AnimationPlayer = $moving_anim

@onready var arm_right: Sprite2D = $arm_1/arm_right
@onready var arm_left: Sprite2D = $LeftArm
@onready var body: Sprite2D = $body
@onready var dash_timer: Timer = $dash_timer

var is_dashing := false

const ARM_LEFT_STAGE_1 = preload("res://sprites/stage_1/arm_left_stage_1.png")
const ARM_RIGHT_STAGE_1 = preload("res://sprites/stage_1/arm_right_stage_1.png")
const BODY_STAGE_1 = preload("res://sprites/stage_1/body_stage_1.png")

const ARM_LEFT_STAGE_2 = preload("res://sprites/stage_2/arm_left_stage_2.png")
const ARM_RIGHT_STAGE_2 = preload("res://sprites/stage_2/arm_right_stage_2.png")
const BODY_STAGE_2 = preload("res://sprites/stage_2/body_stage_2.png")

const ARM_LEFT_STAGE_3 = preload("res://sprites/stage_3/arm_left_stage_3.png")
const ARM_RIGHT_STAGE_3 = preload("res://sprites/stage_3/arm_right_stage_3.png")
const BODY_STAGE_3 = preload("res://sprites/stage_3/body_stage_3.png")

const BODY_STAGE_4 = preload("res://sprites/stage_4/body.png")
const ARM_LEFT_STAGE_4 = preload("res://sprites/stage_4/left_arm.png")
const ARM_RIGHT_STAGE_4 = preload("res://sprites/stage_4/right_arm.png")

@onready var label: Label = $"../HUD/Control/Label"

var lives := 666.0
const BULLET = preload("res://scenes/bullet.tscn")
func _physics_process(delta):
	character_direction.x = Input.get_axis("left", "right")
	character_direction.y = Input.get_axis("up", "down")
	character_direction = character_direction.normalized()
	if is_dashing == true:
		movement_speed = 600
	else:
		movement_speed = 200
	print(movement_speed)
	#flip
	if character_direction.x > 0 : $body.flip_h = true
	elif character_direction.x < 0 : $body.flip_h = false
	
	if character_direction:
		velocity = character_direction * movement_speed
		lives -= 15 * delta
		moving_anim.play("moving")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		moving_anim.stop()
	
	if Input.is_action_just_pressed("dash"):
		is_dashing = true
		lives -= 50
		dash_timer.start()
	move_and_slide()
	

func _process(delta: float) -> void:
	
	if lives <= 0:
		print("You are dead")
	label.text = "lives: " + str(round(lives))
	rotate_towards_mouse()
	if Input.is_action_just_pressed("mouse_left"):
		spawn_bullets()
		lives = lives - 5
	if lives >= 499 and lives < 666:
		change_appearances(ARM_LEFT_STAGE_1,ARM_RIGHT_STAGE_1,BODY_STAGE_1)
	if lives >= 333 and lives < 499:
		change_appearances(ARM_LEFT_STAGE_2,ARM_RIGHT_STAGE_2,BODY_STAGE_2)
	if lives >= 166 and lives < 333:
		change_appearances(ARM_LEFT_STAGE_2,ARM_RIGHT_STAGE_3,BODY_STAGE_3)
	if lives >= 0 and lives < 166:
		change_appearances(ARM_LEFT_STAGE_4,ARM_RIGHT_STAGE_4,BODY_STAGE_4)
func rotate_towards_mouse():
		mouse_pos = get_global_mouse_position()
		arm_1.look_at(mouse_pos)
func spawn_bullets():
	var inst = BULLET.instantiate()
	get_tree().root.add_child(inst)
	inst.global_position = barrel_end.global_position
	inst.global_rotation = barrel_end.global_rotation
#appearance is supposed to change with the amount of blood lost. This functionns handles this
func change_appearances(_arm_left,_arm_right,_body):
	arm_left.texture = _arm_left
	arm_right.texture = _arm_right
	body.texture = _body


func _on_dash_timer_timeout() -> void:
	is_dashing = false
