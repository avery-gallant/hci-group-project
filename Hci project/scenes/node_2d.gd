extends Node2D

@export var tlX:int
@export var tlY:int
@export var len:int
var tlPos
var timeSig = 4
var notes = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass#queue_redraw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _draw() -> void:
	for i in timeSig:
		var n = (float(i)/timeSig)*len
		draw_line(Vector2(tlX+n,tlY),Vector2(tlX+n,tlY+100),Color("000000"),6)
		for j in 4:
			var m = (float(j+1)/4)*(float(len)/timeSig)
			var l = (float(1)/8)*(float(len)/timeSig)
			draw_line(Vector2(tlX+n+m,tlY+20),Vector2(tlX+n+m,tlY+80),Color("000000"),3)
			draw_line(Vector2(tlX+n+m-l,tlY+40),Vector2(tlX+n+m-l,tlY+60),Color("000000"),3)
	draw_line(Vector2(tlX+len,tlY),Vector2(tlX+len,tlY+100),Color("000000"),6)
	for i in notes.keys():
		if (i<=timeSig*8):
			for j in len(notes[i]):
				var y=tlY+50-float(len(notes[i])-1)*10/2+j*10
				var n = float(i)/(timeSig*8)*len
				draw_circle(Vector2(tlX+n,y),5,Color("ffffff"))
	#draw_line(Vector2(tlX,tlY+50),Vector2(tlX+len,tlY+50),Color("000000"),10)
		
func updateNotes(notesIn):
	notes = notesIn
	queue_redraw()

func updateTimeSig(dir):
	timeSig+=dir
	if (timeSig<1):
		timeSig=1
	elif (timeSig>12):
		timeSig=12
	else:
		queue_redraw()
