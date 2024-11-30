extends Node2D

func _ready():
	$PlayButton.visible = false

func _on_pause_button_released() -> void:
	$PauseButton.visible = false
	$PlayButton.visible = true


func _on_play_button_released() -> void:
	$PlayButton.visible = false
	$PauseButton.visible = true
