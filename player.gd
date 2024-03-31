extends CharacterBody2D

const GRAVITY : int = 4200

var direction : int = 1
var jumps : int = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	#add idle animation
	#$AnimatedSprite2D.play("idle")
	pass
	
	
func _physics_process(delta):
	velocity.x += GRAVITY * delta * direction
	if is_on_wall():
		jumps = 0
		if Input.is_action_just_pressed("jump") and velocity.x > 0:
			print("left")
			$AnimatedSprite2D.flip_v = true
			direction = -1
		elif Input.is_action_just_pressed("jump") and velocity.x < 0:
			print("right")
			$AnimatedSprite2D.flip_v = false
			direction = 1
	elif jumps == 0:
		if Input.is_action_just_pressed("jump"):
			jumps += 1
			velocity.x = 0 
			print("reverse_direction")
			direction = direction * -1
			if 	$AnimatedSprite2D.flip_v:
				$AnimatedSprite2D.flip_v = false
			else:
				$AnimatedSprite2D.flip_v = true

	
	move_and_slide()
