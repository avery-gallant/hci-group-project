extends Node2D

@export var bpm : float
@export var timeSig : int

signal on()
signal off()

var beat : int

signal curBeat(beat)

func _ready():
	beat = -1
	bpm = $bpmSlider.value
	$Timer.wait_time = 60/bpm
	$bpmSlider/Label.text = str(bpm)

func _on_timer_timeout():
	emit_signal("loop_reset")
	beat = (1 + beat)%timeSig
	match beat:
		0: $sound1.play()
		_: $sound2.play()

func _on_bpm_slider_value_changed(value):
	bpm = value
	$Timer.wait_time = 60/bpm

func _on_toggle_metronome_toggled(toggled_on):
	if(toggled_on): 
		on.emit()
		$sound1.play()
		$Timer.start()
		beat = 0
	else:
		off.emit()
		$Timer.stop()
