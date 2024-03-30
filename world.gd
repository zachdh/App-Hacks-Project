extends Node2D

var palmtree_scene = preload("res://palmtree.tscn")
var obstacle_types := [palmtree_scene]
var obstacles : Array

const BEACHBALL_START_POS := Vector2i(1114, 578)
const CAM_START_POS := Vector2i(576, 324)

var score : float
var speed : float
var SCORE_MODIFIER : int = 10
const START_SPEED : float = 2
const MAX_SPEED : int = 25
var screen_size : Vector2i
var last_obs



# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size

	new_game()
	
func new_game():
	#reset variables
	score = 0
	#reset nodes
	$Beachball.position = BEACHBALL_START_POS
	$Beachball.velocity = Vector2i(0,0)
	$Camera2D.position = CAM_START_POS
	$Ground.position = Vector2i(0, 648)

#func generate_obs():
	#if obstacles.is_empty():
		#var obs_type = obstacle_types[randi() % obstacle_types.size()]
		#var obs
		#obs = obs_type.instantiate()
		#last_obs = obs
		#add_child(obs)
		#obstacles.append(obs)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed = START_SPEED
	#generate_obs()
	#move character and camera
	$Beachball.position.y -= speed
	$Camera2D.position.y -= speed
	
	score += speed 
	$Camera2D/Score.text = "SCORE: " + str(score)
	
	print($Camera2D.position.y - $Ground.position.y)
	if -1*($Camera2D.position.y - $Ground.position.y) > screen_size.y * 1.5:
		$Ground.position.y -= screen_size.y



