extends HBoxContainer

const ROOM_SIZE = 6

onready var viewers_node = $Viewers

var selected = -1

var starting_index
signal next(selected_index)

func populate(population, starting_index):
	self.starting_index = starting_index
	for i in range(ROOM_SIZE):
		viewers_node.get_child(i).init(population[starting_index+i])





func _on_selected(extra_arg_0):
	if selected == -1:
		$NextButton.visible = true
		pass
	
	selected = starting_index+extra_arg_0


func _on_NextButton_pressed():
	emit_signal("next", selected)
