extends CharacterBody2D

@onready var player: CharacterBody2D = $"."
@onready var player_sprite: Sprite2D = $body/Sprite2D
@onready var hand: RigidBody2D = $PinJoint2D/hand
@onready var shoulder: PinJoint2D = $shoulder


var has_stuff: bool = true
# Dőlés és ugrás változói
var tilt_strength: float = 0.0  # Mennyire dől éppen a karakter
var tilt_direction: int = 0     # -1: balra, 1: jobbra
var is_tilting: bool = false    # Éppen dől-e a karakter
var jump_force: float = 500.0  # Az ugrás ereje
var gravity: float = 900.0     # Gravitáció
var max_tilt_angle: float = 0.5  # Maximális dőlési szög (radiánban)
var friction: float = 0.5      # Csúszás csökkentése (súrlódás)

# Bemenet előre regisztrálása
var pending_tilt: int = 0  # 0: nincs, -1: balra, 1: jobbra

func _physics_process(delta):
	if has_stuff:
		shoulder.rotation = move_toward(shoulder.rotation, 70.0, 2.0)
	
	if is_tilting:
		# Növeljük a dőlés erősségét, amíg a billentyűt nyomva tartjuk
		tilt_strength += 3.0 * delta
		tilt_strength = clamp(tilt_strength, 0.0, 1.0)  # Korlátozzuk az értéket

		# Karakter forgatása a dőlés irányában
		player.rotation = tilt_strength * tilt_direction * max_tilt_angle

	# Gravitáció alkalmazása
	player.velocity.y += gravity * delta

	# Karakter mozgatása
	move_and_slide()

	# Ha a karakter talajon van, állítsuk vissza a függőleges sebességet
	if is_on_floor():
		player.velocity.x *= friction
		if abs(player.velocity.x) < 10.0:
			player.velocity.x = 0.0

		# Ha van előre regisztrált dőlés, kezdjük el a dölést
		if pending_tilt != 0:
			start_tilting(pending_tilt)
			pending_tilt = 0  # Töröljük az előre regisztrált dölést

func _input(event):
	# Ha a karakter még a levegőben van, de megnyomjuk a billentyűt, előre regisztráljuk a dölést
	if event.is_action_pressed("ui_left") and not is_on_floor():  # "W" billentyű
		pending_tilt = -1
	if event.is_action_pressed("ui_right") and not is_on_floor(): # "E" billentyű
		pending_tilt = 1

	# Ha a karakter talajon van, és megnyomjuk a billentyűt, azonnal kezdjük a dölést
	if event.is_action_pressed("ui_left") and is_on_floor():  # "W" billentyű
		start_tilting(-1)  # Balra dőlés
	if event.is_action_pressed("ui_right") and is_on_floor(): # "E" billentyű
		start_tilting(1)   # Jobbra dőlés

	# Ugrás, ha elengedjük a billentyűt
	if event.is_action_released("ui_left") or event.is_action_released("ui_right"):
		jump()

func start_tilting(direction: int):
	tilt_direction = direction
	is_tilting = true
	tilt_strength = 0.0  # Reseteljük a dőlés erősségét

	# Sprite flip_h beállítása a dőlés irányának megfelelően
	player_sprite.flip_h = (direction == 1)  # Jobbra dőlés esetén flip_h = true

func jump():
	if is_tilting:
		is_tilting = false
		# Az ugrás ereje függ a dőlés erősségétől
		player.velocity.y = -jump_force  # Felfelé ugrás
		player.velocity.x = tilt_strength * tilt_direction * jump_force  # Oldalirányú lendület
		tilt_strength = 0.0  # Reseteljük a dőlés erősségét
		player.rotation = 0.0  # Visszaállítjuk a karakter forgását
