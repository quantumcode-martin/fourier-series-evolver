extends Control

const PMUT_RADIUS = 0.3
const PMUT_ANGLE = 0.3
const PMUT_FREQ = 0.2

const MAX_FREQ_MULT = 50

const POOL_SIZE = 6

var generation := 0
var population := []

var selected := []

var trainer_room = preload("res://Training/TrainerRoom.tscn")

var current_room

func update_stats():
	$Population.text = "Population: %d" % population.size()
	$Generation.text = "Generation: %d" % generation

func initiate_population(pop_size):
	for i in range(pop_size):
		population.append({
			0:{'radius':50.0, 'angle': 0.0},
			1:{'radius':50.0, 'angle': 0.0},
#			2:{'radius':50.0, 'angle': 0.0},
			})
		mutate(population[i])
	update_stats()


func mutate(genotype:Dictionary):
	if randf() < PMUT_FREQ:
		var frequencies = genotype.keys().duplicate()
		frequencies.sort()
		
		var freq_mult = frequencies[0]-1 if randi() & 1 else frequencies[-1]+1
		genotype[freq_mult] = {'radius':rand_range(-100.0,100.0), 'angle':rand_range(0.0,180.0)}
	
	for freq_genome in genotype.values():
		if randf() < PMUT_RADIUS:
			freq_genome['radius'] += rand_range(-10.0,10.0)
		if randf() < PMUT_ANGLE:
			freq_genome['angle'] += rand_range(-15.0,15.0)
		

func breed(parent_1, parent_2):
	var child := {}
	
	for freq in parent_1:
		if parent_2.has(freq):
			var lambda = randf()
			child[freq] = {
				'radius':lambda*parent_1[freq]['radius'] + (1.0-lambda)*parent_2[freq]['radius'],
				'angle':lambda*parent_1[freq]['angle'] + (1.0-lambda)*parent_2[freq]['angle'],
				}
		else:
			child[freq] = parent_1[freq]
	return child
		

func evolve():
	var new_population := []
	
	for indiv in selected:
		new_population.append(population[indiv])
		for i in range(POOL_SIZE-1):
			var mate = selected[randi()%selected.size()]
			new_population.append(breed(population[indiv],population[mate]))
	
	for indiv in new_population:
		mutate(indiv)
	
	population = new_population
	population.shuffle()
	selected = []
	generation+=1
	update_stats()

func next_room(selected_indiv):
	selected.append(selected_indiv)
	if (selected.size()+1)*POOL_SIZE > population.size():
		evolve()
	instance_room(selected.size()*POOL_SIZE)

func instance_room(starting_index):
	if current_room != null:
		current_room.queue_free()
	var trainer_room_node = trainer_room.instance()
	add_child(trainer_room_node)
	trainer_room_node.populate(population, selected.size()*POOL_SIZE)
	trainer_room_node.connect("next", self, "next_room")
	current_room = trainer_room_node

func _ready():
	randomize()
	initiate_population(30)
	
	instance_room(0)

var started := false
func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		if !started:
			started = true
			var timetween = Tween.new()
			add_child(timetween)
			timetween.interpolate_property(TimeManager,'speed', 0.0, 0.9, 1.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
			timetween.start()
