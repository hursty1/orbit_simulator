extends GravityObject

class_name CelestialBody

@export var radius : float 
@export var surfaceGravity : float
@export var initalVelocity: Vector3
@export var bodyName : String = "unnamed"

@export var mass : float
@export var velocity : Vector3

@onready var rb : RigidBody3D = $RigidBody3D
func _init(): #called when game starts reguardless of if this item is loaded
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("CelestialBody")
	rb.mass = mass
	velocity = initalVelocity




func UpdateVelocity(allBodies: Array[CelestialBody], timeStep:float):
	
	for otherBody in allBodies:
		if otherBody != self:
			var sqrDst : float = (otherBody.rb.position - rb.position).length_squared()
			var forceDir : Vector3 = (otherBody.rb.position - rb.position).normalized()
			
			var force : Vector3 = forceDir * Constants.gravitationalConstant * otherBody.mass * rb.mass / sqrDst #universal constant
			var acceleration = force / rb.mass
			velocity += acceleration * timeStep

func updateVelocitySingle(acceleration : Vector3, timeStep : float):
#	print(rb.mass)
	velocity += acceleration * timeStep
	print(velocity)

func updatePosition(timeStep:float):
	var dir : Vector3 = (rb.position + velocity * timeStep).normalized()
	rb.translate(dir)
#	rb.velocity
	
