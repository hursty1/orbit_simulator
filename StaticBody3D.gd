extends Node3D


@export var radius : float 
@export var surfaceGravity : float
@export var initalVelocity: Vector3
@export var bodyName : String = "unnamed"

@export var mass : float = 1.0
@export var velocity : Vector3

@onready var rb : StaticBody3D
func _init(): #called when game starts reguardless of if this item is loaded
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("CelestialBody")
	print(mass)
	rb.mass = mass
	velocity = initalVelocity




func UpdateVelocity(allBodies: Array[CelestialBody], timeStep:float):
	
	for body in allBodies:
		if body != self:
			var sqrDst : float = (body.rb.position - rb.position).length_squared()
			var forceDir : Vector3 = (body.rb.position - rb.position).normalized()
			
			var acceleration : Vector3 = forceDir * Constants.gravitationalConstant * body.mass / sqrDst #universal constant
			velocity += acceleration * timeStep

func updateVelocitySingle(acceleration : Vector3, timeStep : float):
#	print(rb.mass)
	velocity += acceleration * timeStep
	

func updatePosition(timeStep:float):
	
	rb.translate(rb.position + velocity * timeStep)
