extends Node2D

var palmtree_scene = preload("res://Scenes/palmtree.tscn")
var obstacle_types := [palmtree_scene]
var obstacles : Array

const BEACHBALL_START_POS := Vector2i(1844, 850)
const CAM_START_POS := Vector2i(960, 540)

var score : float
var speed : float
var SPEED_MODIFIER : int = 10
const START_SPEED : float = 2
const MAX_SPEED : int = 4
var screen_size : Vector2i
var last_obs
var game_running : bool = false
var obs_spawn = [
	{
		"position" : Vector2i(1802, -1080), 
		"rotation" : -90,
		"flip-h" : true,
	},
	{
		"position" : Vector2i(50, -1080),
		"rotation" : 90,
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
	if obstacles.is_empty():
		var obs_type = obstacle_types[randi() % obstacle_types.size()]
		var obs
		obs = obs_type.instantiate()
		last_obs = obs
		var rand_spawn = obs_spawn[randi() % obs_spawn.size()]
		obs.position = obs_spawn[rand_spawn]["position"]
		obs.rotation_degrees = obs_spawn[0]["rotation"]
		obs.get_node("Sprite2D").flip_h = obs_spawn[0]["flip-h"]
		
		add_child(obs)
		obstacles.append(obs)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		speed = START_SPEED
		generate_obs()
		#move character and camera
		$Beachball.position.y -= speed
		$Camera2D.position.y -= speed
		
		$Camera2D/HUD.get_node("StartLabel").visible = false
		score += speed

		$Camera2D/HUD.get_node("ScoreLabel").text = "SCORE: " + str(score)

		if -1*($Camera2D.position.y - $Ground.position.y) > screen_size.y * 1.5:
			$Ground.position.y -= screen_size.y
	else:
		if Input.is_action_just_pressed("jump"):
			$Beachball.get_node("AnimatedSprite2D").play("run")
			game_running = true
	



