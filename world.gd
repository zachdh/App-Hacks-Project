extends Node2D

var palmtree_scene = preload("res://Scenes/palmtree.tscn")
var obstacle_types := [palmtree_scene]
var obstacles : Array

const BEACHBALL_START_POS := Vector2i(1844, 850)
const CAM_START_POS := Vector2i(960, 540)

var score : int
var speed : float
var SPEED_MODIFIER : int = 1000
var SCORE_MODIFIER : int = 10
const START_SPEED : float = 10
const MAX_SPEED : int = 15
var screen_size : Vector2i
var last_obs
var game_running : bool = false
var obs_spawn = [
	{
		"position" : Vector2i(1801, -1*(screen_size.y + score + 100)), 
		"rotation" : -90,
		"flip-h" : true,
	},
	{
		"position" : Vector2i(120, -1*(screen_size.y + score + 100)),
		"rotation" : 90,
		"flip-h" : false,
	}
]


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
	$Ground.position = Vector2i(0, 1080)
	$Camera2D/HUD.get_node("StartLabel").visible = true

func generate_obs():
	if obstacles.is_empty() or -1*(last_obs.position.y) > score + randi_range(300, 500):
		var obs_type = obstacle_types[randi() % obstacle_types.size()]
		var obs
		var max_obs = 2
		for i in range(randi() % max_obs + 1):
			obs = obs_type.instantiate()
			last_obs = obs
			var rand_spawn = randi() % obs_spawn.size()
			obs.position = obs_spawn[rand_spawn]["position"]
			obs.rotation_degrees = obs_spawn[rand_spawn]["rotation"]
			obs.get_node("Sprite2D").flip_h = obs_spawn[rand_spawn]["flip-h"]
			add_child(obs)
			obstacles.append(obs)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		speed = START_SPEED + score / SPEED_MODIFIER
		if speed > MAX_SPEED:
			speed = MAX_SPEED
		generate_obs()
		#move character and camera
		$Beachball.position.y -= speed
		$Camera2D.position.y -= speed
		
		$Camera2D/HUD.get_node("StartLabel").visible = false
		score += speed / SCORE_MODIFIER

		$Camera2D/HUD.get_node("ScoreLabel").text = "SCORE: " + str(score)

		if -1*($Camera2D.position.y - $Ground.position.y) > screen_size.y * 1.5:
			$Ground.position.y -= screen_size.y
	else:
		if Input.is_action_just_pressed("jump"):
			$Beachball.get_node("AnimatedSprite2D").play("run")
			game_running = true
	



