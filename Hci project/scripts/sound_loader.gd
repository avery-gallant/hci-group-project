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

func _ready():
	$bigButton.shape.radius = 3*ringRadius
	visible = false
	scanFile()
	placeButtons()
	
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
		text.text = button.name
		button.add_child(text)
		button.mouse_exited.connect(onReleased)
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
	$buttons.get_child(i).position.x = radius*cos(theta)
	$buttons.get_child(i).position.y = radius*sin(theta)
	
func onReleased():
	print("released")

func onBigRelease():
	visible = false
