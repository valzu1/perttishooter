extends KinematicBody2D

var bullet = preload("res://Scenes/Bullet.tscn")
var movement = Vector2()

var can_fire = true

func _process(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("fire") and can_fire:
		_fire()

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		movement.x += Settings.pertti_speed
	if Input.is_action_pressed("left"):
		movement.x -= Settings.pertti_speed
	if Input.is_action_pressed("up"):
		movement.y -= Settings.pertti_speed
	if Input.is_action_pressed("down"):
		movement.y += Settings.pertti_speed
		
	move_and_slide(movement)
	movement.x = 0
	movement.y = 0

func _fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = $BulletPoint.get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees 
	bullet_instance.apply_impulse(Vector2(), Vector2(Settings.bullet_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(bullet_instance)
	can_fire = false
	yield(get_tree().create_timer(Settings.fire_rate), "timeout")
	can_fire = true