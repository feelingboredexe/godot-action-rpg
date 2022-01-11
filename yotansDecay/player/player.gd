extends KinematicBody2D

const ACCELERATION = 400
const MAX_SPEED = 100
const FRICTION = 800

var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer # same as the statement below 
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

#func _ready():
#	animationPlayer = $AnimationPlayer (dollar sign is short hand for getting into a node)


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	# get x movement value
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	# get y movement value
	input_vector = input_vector.normalized()
	# normalize vector
	
	
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/idle/blend_position", input_vector)
		animationTree.set("parameters/run/blend_position", input_vector)
		animationState.travel("run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		# vector multiplied by max speed, acceleration multiplied by delta to reduce lag
	else:
		animationState.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	
	move_and_slide(velocity)
	# moving func
