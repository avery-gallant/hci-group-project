extends Node2D

@export var spacing : float
@export var buttonWidth : float
@export var dimensions : Vector2

var colours : Array = [	
	Color(1, 0, 0), 
	Color(0.09411,0.6078,0.8), 
	Color(0.09411,0.6078,0.8), 
	Color(0.09411,0.6078,0.8), 
	Color(0.09411,0.6078,0.8), 
	Color(0.09411,0.6078,0.8), 
	Color(0.09411,0.6078,0.8), 
	Color(0.09411,0.6078,0.8), 
	Color(0.09411,0.6078,0.8), 
	Color(0.09411,0.6078,0.8), 
	Color(0.09411,0.6078,0.8), 
	Color(0.09411,0.6078,0.8)
]

func _ready():
	var xIndex : int = 0
	var yIndex : int = 0
	var i = 0
	for button in get_children():
		button.position = Vector2(spacing + xIndex*(buttonWidth+spacing), spacing + yIndex*(buttonWidth+spacing))
		if((xIndex+1)%int(dimensions.x) == 0): yIndex+=1
		xIndex = (xIndex+1)%int(dimensions.x)
		button.colour = Color(colours[i].r8,colours[i].g8,colours[i].b8)
		print(button.colour)
		i += 1
