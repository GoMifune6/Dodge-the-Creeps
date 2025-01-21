extends Area2D
signal hit
# How fast the player moves. Lower values mean slower player.
@export var speed = 400
var screen_size # Size of the game window. We make this global for later.

# THINGS TO CHANGE:
# MAKE PLAYER STILL FACE DOWN WHEN TRAVELING DOWN
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	# pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#This should start 0 by default unless we want forced movement
	var velocity = Vector2.ZERO #This is the player movement vector.
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	# Now that we have player behavior 
	#The delta parameter in the _process() function refers to the frame length - the amount of time that the previous frame took to complete
	# Using this value ensures that your movement will remain consistent even if the frame rate changes.
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	#player
	if velocity.x != 0:
		$AnimatedSprite2D.animation = 'walk'
		#$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.animation = 'up'
		$AnimatedSprite2D.flip_v = velocity.y > 0
	
	#pass


func _on_body_entered(body: Node2D) -> void:
	hide()
	#Any way to add a scream soundbite when 
	hit.emit()
	$CollisionShape2D.set_deferred('disabled', true)
	#pass # Replace with function body.
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
