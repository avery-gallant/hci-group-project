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
	$metronome/TSDN.pressed.connect($tl.updateTimeSig.bind(-1))
	$metronome/TSUP.pressed.connect($tl.updateTimeSig.bind(1))
	sttime = Time.get_ticks_msec()
	
	buttonArr = [$soundButtons/grid1/SoundButton,$soundButtons/grid1/SoundButton2,$soundButtons/grid1/SoundButton3,$soundButtons/grid1/SoundButton4,$soundButtons/grid1/SoundButton5,$soundButtons/grid1/SoundButton6,$soundButtons/grid1/SoundButton7,$soundButtons/grid1/SoundButton8,$soundButtons/grid1/SoundButton9,$soundButtons/grid1/SoundButton10,$soundButtons/grid1/SoundButton11,$soundButtons/grid1/SoundButton12]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func notePress(id):
	if (rec):
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
	if(timeArr.has(noteCount)&&play):
		for item in timeArr[noteCount]:
			buttonArr[item-1].playNote()

func _on_record_button_pressed() -> void:
	rec = !rec

func _on_play_button_pressed() -> void:
	play = !play
	if play:
		$PlayButton.icon=pauseIcon
	else:
		$PlayButton.icon=playIcon
	
	
	
	
	
	
	
	
