extends Node2D


var started = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$FourierViewer.init(
		{
			0:{'radius': 100, 'angle': 50},
			1:{'radius': 90, 'angle': 90},
			-1:{'radius': 80, 'angle': -20},
			2:{'radius': 85, 'angle': 10},
			-2:{'radius': 79, 'angle': 0},
			3:{'radius': 40, 'angle': 3},
			-3:{'radius': 60, 'angle': 58},
			4:{'radius': 32, 'angle': 10},
			-4:{'radius': 34, 'angle': 9},
			5:{'radius': 23, 'angle': 54},
			-5:{'radius': 30, 'angle': 170},
			6:{'radius': 12, 'angle': 99},
			-6:{'radius': 6, 'angle': 21},
		}
	)
	$FourierViewer2.init(
		{
			0:{'radius': 60, 'angle': 50},
			1:{'radius': 110, 'angle': 10},
			-1:{'radius': 120, 'angle': -10},
			2:{'radius': 80, 'angle': 20},
			-2:{'radius': 79, 'angle': 30},
			3:{'radius': 40, 'angle': 3},
			-3:{'radius': 60, 'angle': 30},
			4:{'radius': 32, 'angle': 10},
			-4:{'radius': 10, 'angle': 9},
			5:{'radius': 23, 'angle': 54},
			-5:{'radius': 30, 'angle': 170},
			6:{'radius': 12, 'angle': 99},
			-6:{'radius': 6, 'angle': 21},
		}
	)
	$FourierViewer3.init(
		{
			0:{'radius': 12, 'angle': 50},
			1:{'radius': 110, 'angle': 10},
			-1:{'radius': 120, 'angle': -10},
			2:{'radius': 110, 'angle': 40},
			-2:{'radius': 79, 'angle': 30},
			3:{'radius': 40, 'angle': 160},
			-3:{'radius': 5, 'angle': 2},
			4:{'radius': 60, 'angle': 10},
			-4:{'radius': 10, 'angle': 9},
			5:{'radius': 23, 'angle': 54},
			-5:{'radius': 30, 'angle': 170},
			6:{'radius': 12, 'angle': 99},
			-6:{'radius': 30, 'angle': 10},
		}
	)
	$FourierViewer4.init(
		{
			0:{'radius': 60, 'angle': 50},
			1:{'radius': 110, 'angle': 10},
			-1:{'radius': 120, 'angle': -10},
			2:{'radius': 20, 'angle': 20},
			-2:{'radius': 80, 'angle': 30},
			3:{'radius': 10, 'angle': 90},
			-3:{'radius': 60, 'angle': 30},
			4:{'radius': 32, 'angle': 10},
			-4:{'radius': 50, 'angle': 9},
			5:{'radius': 23, 'angle': -10},
			-5:{'radius': 30, 'angle': 30},
			6:{'radius': 12, 'angle': 1},
			-6:{'radius': 23, 'angle': 21},
		}
	)

	

func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		if !started:
			started = true
			var timetween = Tween.new()
			add_child(timetween)
			timetween.interpolate_property(TimeManager,'speed', 0.0, 0.3, 1.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
			timetween.start()
