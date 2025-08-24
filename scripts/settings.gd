extends Control

@onready var sound_slider: HSlider = $Sound_Slider
@onready var item_list: ItemList = $ItemList

@export var bus_name: String
var resolutions_width = [2560, 1920, 1366, 1280]
var resolutions_height = [1440, 1080, 768, 720]
var bus_index: int
var is_in_settings := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("escape") and is_in_settings == true:
		hide()
		Engine.time_scale = 1
	if Input.is_action_just_pressed("escape") and is_in_settings == false:
		show()
		Engine.time_scale = 0
		
	if Input.is_action_just_pressed("escape"):
		is_in_settings = not is_in_settings

func _on_sound_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
		)
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))




func _on_option_button_item_selected(index: int) -> void:
	print(index)
	get_window().set_size(Vector2(resolutions_width[index], resolutions_height[index]))
	get_window().move_to_center()


func _on_screen_stretch_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
