extends Node2D

@export var spawn_point: Vector2 = Vector2(0,0)
@export var level_number: int = 1




@onready var player: CharacterBody2D = $kare 
@onready var timer_label: Label = $HUD/timerLabel
@onready var result_panel: PanelContainer = $HUD/PanelContainer
@onready var result_label: Label = $HUD/PanelContainer/VBoxContainer/resultLabel


var elapsed_time: float = 0.0
var timer_running: bool = false
var level_finished: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for spike in $spikes.get_children():
		if spike is Area2D:
			spike.body_entered.connect(_on_spike_body_entered) 
			result_panel.visible = false
			
			
			
			
	_start_timer()


		
func _process(delta) ->void:
	if timer_running:
		elapsed_time += delta
		_update_timer_label()

func _start_timer()->void:
	elapsed_time = 0
	timer_running = true
	level_finished = false
	_update_timer_label()

func _update_timer_label():
	timer_label.text = "%.2f sec " % elapsed_time



func _on_spike_body_entered(body:Node2D) -> void:
	if body==player:
		player.global_position = spawn_point
		player.velocity = Vector2.ZERO
		


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_finish_area_body_entered(body: Node2D) -> void:
	if body != player or level_finished:
		return
		level_finished = true 
		timer_running = false

	result_label.text="level finished!\n time: %.2f sec" % elapsed_time
	result_panel.visible = true
