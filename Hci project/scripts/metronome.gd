extends Node2D

@export var bpm : float
@export var timeSig : int
@export var shapeOffsetX : int
@export var shapeOffsetY : int
@export var shapeScale : int

var beat : int
var shapePts : PackedVector2Array = []
var shape
var innerShape
var beatPt : Vector2
var noteCount=0
var on = false

func _ready():
	beat = 0
	bpm = $bpmSlider.value
	$Timer.wait_time=(1/(bpm/60))/8
	$bpmSlider/Label.text = str(bpm)
	
	shape = Line2D.new()
	shape.z_index=z_index-2
	shape.set_joint_mode(shape.LINE_JOINT_ROUND)
	shape.default_color = Color("000000")
	shape.width = 15
	shape.closed = true
	add_child(shape)
	
	innerShape = Line2D.new()
	innerShape.z_index=z_index-2
	innerShape.default_color = Color("ffffff")
	innerShape.width=1
	innerShape.closed = true
	add_child(innerShape)

	for i in timeSig:
		var t = (timeSig-(i+1))*(2*PI/timeSig)
		var pt = Vector2(shapeScale*sin(t)+shapeOffsetX, shapeScale*cos(t)+shapeOffsetY)
		shapePts.append(pt)
		shape.add_point(pt)
		innerShape.add_point(pt)

func _process(delta):
	beatPt = shapePts[beat].lerp(shapePts[(1 + beat)%timeSig], ((($Timer.wait_time*noteCount)+$Timer.wait_time-$Timer.time_left)/($Timer.wait_time*8))**8)
	queue_redraw()

func _on_timer_timeout():
	noteCount+=1
	if (noteCount==8):
		noteCount=0
		beat = (1 + beat)%timeSig
		if (on):
			match beat:
				0: $sound1.play()
				_: $sound2.play()

func _on_toggle_metronome_toggled(toggled_on):
	on=toggled_on

func _draw() -> void:
	var godot_blue : Color = Color("478cbf")
	draw_circle(shapePts[0],3,Color("ffffff"))
	if (on):
		draw_circle(beatPt,5,godot_blue)

func _on_tsup_pressed() -> void:
	if (timeSig<12):
		timeSig+=1
		setPts()

func _on_tsdn_pressed() -> void:
	if timeSig>1:
		timeSig-=1
		if (beat>=timeSig):
			beat=timeSig-1
		setPts()

func setPts():
	shapePts.clear()
	shape.clear_points()
	innerShape.clear_points()
	for i in timeSig:
		var t = (timeSig-(i+1))*(2*PI/timeSig)
		var pt = Vector2(shapeScale*sin(t)+shapeOffsetX, shapeScale*cos(t)+shapeOffsetY)
		shapePts.append(pt)
		shape.add_point(pt)
		innerShape.add_point(pt)


func _on_bpm_slider_value_changed(value: float) -> void:
	$Timer.wait_time=(1/(value/60))/8
