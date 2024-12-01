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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$soundButtons/grid1/SoundButton.pressed.connect(notePress.bind(1))
	$soundButtons/grid1/SoundButton2.pressed.connect(notePress.bind(2))
	$soundButtons/grid1/SoundButton3.pressed.connect(notePress.bind(3))
	$soundButtons/grid1/SoundButton4.pressed.connect(notePress.bind(4))
	$soundButtons/grid1/SoundButton5.pressed.connect(notePress.bind(5))
	$soundButtons/grid1/SoundButton6.pressed.connect(notePress.bind(6))
	$soundButtons/grid1/SoundButton7.pressed.connect(notePress.bind(7))
	$soundButtons/grid1/SoundButton8.pressed.connect(notePress.bind(8))
	$soundButtons/grid1/SoundButton9.pressed.connect(notePress.bind(9))
	$soundButtons/grid1/SoundButton10.pressed.connect(notePress.bind(10))
	$soundButtons/grid1/SoundButton11.pressed.connect(notePress.bind(11))
	$soundButtons/grid1/SoundButton12.pressed.connect(notePress.bind(12))
	 
	bpm=$metronome.bpm
	$metronome/Timer.timeout.connect(_on_timer_timeout)
	$metronome/updown/TSDN.pressed.connect($tl.updateTimeSig.bind(-1))
	$metronome/updown/TSUP.pressed.connect($tl.updateTimeSig.bind(1))
	sttime = Time.get_ticks_msec()
	
	buttonArr = [$soundButtons/grid1/SoundButton,$soundButtons/grid1/SoundButton2,$soundButtons/grid1/SoundButton3,$soundButtons/grid1/SoundButton4,$soundButtons/grid1/SoundButton5,$soundButtons/grid1/SoundButton6,$soundButtons/grid1/SoundButton7,$soundButtons/grid1/SoundButton8,$soundButtons/grid1/SoundButton9,$soundButtons/grid1/SoundButton10,$soundButtons/grid1/SoundButton11,$soundButtons/grid1/SoundButton12]
	$tl.colors = $soundButtons/grid1.colours
	
	lightTextures = [load("res://texture/light_off.png"), load("res://texture/light_on.png")]
	lightIdx = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func notePress(id):
	if (rec&&buttonArr[id-1].active):
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


func _on_clear_button_released() -> void:
	timeArr = {}
	$tl.updateNotes(timeArr)
