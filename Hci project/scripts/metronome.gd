extends Node2D

@export var bpm : float
@export var timeSig : int
@export var shapeOffsetX : int
@export var shapeOffsetY : int
@export var shapeScale : int
var beat : int
var shapePts : PackedVector2Array = []
func _ready():
	beat = -1
	bpm = $bpmSlider.value
	$Timer.wait_time = 60/bpm
	$bpmSlider/Label.text = str(bpm)
	
	for i in timeSig:
		var t = i*(2*PI/timeSig)
		shapePts.append(Vector2(shapeScale*sin(t)+shapeOffsetX, shapeScale*cos(t)+shapeOffsetY))

func _process(delta):
	pass

func _on_timer_timeout():
	beat = (1 + beat)%timeSig
	match beat:
		0: $sound1.play()
		_: $sound2.play()

func _on_bpm_slider_value_changed(value):
	bpm = value
	$Timer.wait_time = 60/bpm

func _on_toggle_metronome_toggled(toggled_on):
	if(toggled_on): 
		$sound1.play()
		$Timer.start()
		beat = 0
	else:
		$Timer.stop()
		
func _draw() -> void:
	var godot_blue : Color = Color("478cbf")
	# We pass the PackedVector2Array to draw the shape.
	draw_polygon(shapePts, [ godot_blue ])
		
