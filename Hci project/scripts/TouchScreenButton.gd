extends TouchScreenButton
var music
var audio_loader


var c = Image.load_from_file("res://texture/button_pressed_empty.png"); 
var d = Image.load_from_file("res://texture/button_empty.png");

var a = Image.load_from_file("res://texture/button.png"); 
var b = Image.load_from_file("res://texture/button_pressed.png");
var full_depressed = ImageTexture.create_from_image(a); 
var full_pressed = ImageTexture.create_from_image(b);

var empty_depressed = ImageTexture.create_from_image(d); 
var empty_pressed = ImageTexture.create_from_image(c);

@export var colour: Color

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(empty_depressed)
	texture_normal = empty_depressed
	texture_pressed = empty_pressed
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
	$soundLoader.visible = false

func _on_timer_timeout():
	visible=false
	$soundLoader.visible=true
	visible=true

func _on_sound_loader_load_sound(file) -> void:
	music.set_stream(audio_loader.loadfile(file))
	music.volume_db = 1
	music.pitch_scale = 1
	texture_normal = full_depressed
	texture_pressed = full_pressed
