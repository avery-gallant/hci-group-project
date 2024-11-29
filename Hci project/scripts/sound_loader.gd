extends Node2D

var dir
@export var path : String

@export var ringRadius : float
var buttonRadius : float
@export var maxRow : int
@export var spacing : float

var numButtons

var xCoord = 0
var yCoord = 0

var music
var audioLoader

signal loadSound

func _ready():
	$bigButton/CollisionShape2D.shape.radius = 3*ringRadius
	visible = false
	scanFile()
	placeButtons()
	
	music = AudioStreamPlayer.new()
	add_child(music)
	audioLoader = AudioLoader.new()
	
func scanFile():
	dir = DirAccess.open(path)
	dir.list_dir_begin()
	var file = dir.get_next()
	while file != "":
		var button = Area2D.new()
		button.name = file
		
		var shape = CollisionShape2D.new()
		shape.name = "shape"
		shape.shape = CircleShape2D.new()
		button.add_child(shape)
		
		var text = Label.new()
		text.name = "text"
		text.text = button.name
		button.add_child(text)
		
		button.mouse_entered.connect(onEntered.bind(button.name))
		button.mouse_exited.connect(onReleased.bind(button.name))
		
		$buttons.add_child(button)
		
		file = dir.get_next()
		file = dir.get_next()
	dir.list_dir_end()

func placeButtons():
	numButtons = $buttons.get_child_count()
	buttonRadius = ringRadius/(4) - spacing
	var theta = PI/min(numButtons+1, maxRow+1)
	var i = 0
	while(theta < PI):
		placeOnCircle(ringRadius, theta, i)
		theta += PI/min(numButtons+1, maxRow+1)
		i += 1
	
	if(numButtons > maxRow):
		ringRadius = 1.5*ringRadius
		theta = PI/(numButtons - maxRow + 1)
		i = maxRow
		while(theta < PI):
			placeOnCircle(ringRadius, theta, i)
			theta += PI/(numButtons - maxRow + 1)
			i += 1

func placeOnCircle(radius : float, theta: float, i: int):
	$buttons.get_child(i).get_node("shape").shape.radius = buttonRadius
	$buttons.get_child(i).get_node("text").position = -$buttons.get_child(i).get_node("text").size/2
	$buttons.get_child(i).position.x = radius*cos(theta)
	$buttons.get_child(i).position.y = radius*sin(theta)
	
func onReleased(name : String):
	if(!visible):
		var file = path + name.replace("_", ".")
		loadSound.emit(file)
		
func onEntered(name: String):
	var file = path + name.replace("_", ".")
	music.set_stream(audioLoader.loadfile(file))
	music.volume_db = 1
	music.pitch_scale = 1
	music.play()
	

func onBigRelease():
	visible = false

func _on_big_button_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if(event is InputEventScreenTouch): 
		visible = false
