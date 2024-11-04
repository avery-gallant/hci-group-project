extends Node2D

#currently has a preset loop only, no recording

var isTracking
var loops
var numLoops
var currentLoop
var currentBeat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isTracking = false
	numLoops=0
	#loops == [numLoops][32][12] #the loop, frames in loop, which pads play in the frame

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_metronome_on() -> void:
	isTracking = true
	
func _on_metronome_off() -> void:
	isTracking = false

func _on_record_button_pressed() -> void:
	if isTracking == true:
		#initialize blank array for recording loop
		currentLoop = [32]
		for i in range(0, 31):
			currentLoop[i] = 0
		
		print(currentLoop)
		#numLoops = numLoops + 1
		
func _on_metronome_cur_beat(beat: int) -> void:
	currentBeat = beat
