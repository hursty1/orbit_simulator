extends Node3D

class_name NBodySimulation


var bodies : Array

# Called when the node enters the scene tree for the first time.
func _ready():
#	Engine.iterations_per_second = 60
	bodies = get_tree().get_nodes_in_group("CelestialBody")
	print(len(bodies))


func _process(_delta):
	for body in bodies:
		var acceleration : Vector3 = CalculateAcceleration(body.position, body)
		body.updateVelocitySingle(acceleration, Constants.physicsTimeStep)
#		body.UpdateVelocity(Constants.physicsTimeStep)
		
	for b in bodies:
		b.updatePosition(Constants.physicsTimeStep)

func CalculateAcceleration(point: Vector3, ignoreBody:CelestialBody = null):
	var acceleration : Vector3 = Vector3.ZERO
	for body in bodies:
		if (body != ignoreBody):
			var sqrDst : float = (body.rb.position - point).length_squared()
			var forceDir : Vector3 = (body.rb.position - point).normalized()
			print("forDir is: " + str(forceDir))
			acceleration += forceDir * Constants.gravitationalConstant * body.mass / sqrDst #universal constant
			print("acel is: " + str(acceleration))
	return acceleration
	
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
