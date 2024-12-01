extends Node2D

@export var spacing : float
@export var buttonWidth : float
@export var dimensions : Vector2

var colours : Array = [	
	Color(1, 0, 0), 
	Color(0,0,1), 
	Color(0,1,0), 
	Color(1,1,0), 
	
	Color(1, 0.40,0.19), 
	Color(0.448,0,1), 
	Color(0.552,0.711,0), 
	Color(0.577,0.517,0), 
	
	Color(0.577, 0.241, 0), 
	Color(0.5,0.5,1), 
	Color(0.5,1,0.5), 
	Color(0.8,0.8,0.5)
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
		i += 1
