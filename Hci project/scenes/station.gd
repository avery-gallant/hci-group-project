extends Node2D

var sttime
var timeArr = {}
var bpm
var noteCount =0
var rec = false
var buttonArr
var play = false
var a = Image.load_from_file("res://texture/pausebutton.png"); 
var b = Image.load_from_file("res://texture/playbutton.png");
var playIcon = ImageTexture.create_from_image(a); 
var pauseIcon = ImageTexture.create_from_image(b);
var lightTextures: Array
var lightIdx : int
@export var selecting : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var soundButtons = $soundButtons/grid1.get_children()
	for i in soundButtons.size():
		soundButtons[i].pressed.connect(notePress.bind(i+1))
	 
	bpm=$metronome.bpm
	$metronome/Timer.timeout.connect(_on_timer_timeout)
	$metronome/updown/TSDN.pressed.connect($tl.updateTimeSig.bind(-1))
	$metronome/updown/TSUP.pressed.connect($tl.updateTimeSig.bind(1))
	sttime = Time.get_ticks_msec()
	
	buttonArr = [$soundButtons/SoundButton,$soundButtons/SoundButton2,$soundButtons/SoundButton3,$soundButtons/SoundButton4,$soundButtons/SoundButton5,$soundButtons/SoundButton6,$soundButtons/SoundButton7,$soundButtons/SoundButton8,$soundButtons/SoundButton9,$soundButtons/SoundButton10,$soundButtons/SoundButton11,$soundButtons/SoundButton12]
	$tl.colors = $soundButtons.colours
	
	lightTextures = [load("res://texture/light_off.png"), load("res://texture/light_on.png")]
	lightIdx = 0
	
	selecting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func notePress(id):
	if ($ClearButton.on):
		for i in timeArr.keys():
			timeArr[i].erase(id)
		$tl.updateNotes(timeArr)
	elif (rec&&buttonArr[id-1].active):
		if(timeArr.has(noteCount)):
			for i in timeArr[noteCount]:
				if i == id:
					return
			
			timeArr[noteCount]+=[id]
		else:
			timeArr[noteCount]=[id]
		$tl.updateNotes(timeArr)

func _on_timer_timeout() -> void:
	noteCount+=1
	if (noteCount>=8*$metronome.timeSig):
		noteCount=0
	if (play or rec):
		$tl.updateBeat(noteCount)
	if(timeArr.has(noteCount)&&play):
		for item in timeArr[noteCount]:
			buttonArr[item-1].playNote()

func _on_record_button_pressed() -> void:
	lightIdx = (lightIdx + 1)%lightTextures.size()
	$playbackButtons/light.texture = lightTextures[lightIdx]
	rec = !rec
	$tl.doTime = rec or play
	$tl.queue_redraw()#436

func _on_play_button_released() -> void:
	play = true
	$tl.doTime = rec or play
	$tl.queue_redraw()

func _on_pause_button_released() -> void:
	play = false
	$tl.doTime = rec or play
	$tl.queue_redraw()
