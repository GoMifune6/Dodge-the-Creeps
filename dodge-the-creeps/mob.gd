extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass # Replace with function body.
	# We need to assign the animations to the mob and
	# have it randomly choose between the 3.
	# This returns an array with the three animation names.
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	# This will play a random animation by randi() % n selects a random integer between 0 and n-1
	$AnimatedSprite2D.play(mob_types[randi()%mob_types.size()])
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
