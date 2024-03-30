extends CharacterBody2D

const GRAVITY : int = 4200



var starting_x
var starting_y
var direction : int = 1


# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	$AnimatedSprite2D.play()
	starting_x = self.position.x
	starting_y = self.position.y
	
func _physics_process(delta):
	velocity.x += GRAVITY * delta * direction
	if is_on_wall():
		if Input.is_action_pressed("jump_left"):
			print("left")
			$AnimatedSprite2D.flip_v = true
			direction = -1
		elif Input.is_action_pressed("jump_right"):
			print("right")
			$AnimatedSprite2D.flip_v = false
			direction = 1
			
	move_and_slide()
