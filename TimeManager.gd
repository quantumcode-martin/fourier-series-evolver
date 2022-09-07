extends Node

const N = 4
var time := 0.0

var speed = 0.0

func _process(delta):
	time+=delta*speed

