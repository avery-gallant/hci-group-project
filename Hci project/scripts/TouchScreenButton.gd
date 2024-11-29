extends TouchScreenButton
var music
var audio_loader
@onready var fd_get = $FileDialog
@export var id:int

var c = Image.load_from_file("res://texture/button_pressed_empty.png"); 
var d = Image.load_from_file("res://texture/button_empty.png");

var a = Image.load_from_file("res://texture/button.jpg"); 
var b = Image.load_from_file("res://texture/button_pressed.jpg");
var full_depressed = ImageTexture.create_from_image(a); 
var full_pressed = ImageTexture.create_from_image(b);

var empty_depressed = ImageTexture.create_from_image(d); 
var empty_pressed = ImageTexture.create_from_image(c);

var depressedIcon = empty_depressed
var pressedIcon = empty_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	
	texture_normal = empty_depressed
	texture_pressed = empty_pressed
	fd_get.visible=false
	music = AudioStreamPlayer.new()
	audio_loader = AudioLoader.new()
	add_child(music)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	$Timer.start()
	music.play()

func _on_released():
	$Timer.stop()

func _on_timer_timeout():
	visible=false
	fd_get.visible=true
	visible=true

func _on_file_dialog_file_selected(path):
	fd_get.visible=false
	music.set_stream(audio_loader.loadfile(path))
	music.volume_db = 1
	music.pitch_scale = 1
	depressedIcon = full_depressed
	pressedIcon = full_pressed
	texture_normal = full_depressed
	texture_pressed = full_pressed

func playNote() -> void:
	music.play()
	$Timer2.start()
	texture_normal=pressedIcon
	


func _on_timer_2_timeout() -> void:
	texture_normal=depressedIcon
