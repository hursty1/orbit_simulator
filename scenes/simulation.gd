@tool
extends Node

@export var num_steps: int = 2000
@export var time_step: float = 0.1
@export var use_physics_time_step: bool = false

@export var relative_to_body: bool = false
@export var central_body: Node
@export var width: float = 100
@export var use_thick_lines: bool = false

# Assuming you have a Universe singleton with a physics_time_step variable
# and gravitational_constant for easier access.
const GRAVITATIONAL_CONSTANT = Constants.gravitationalConstant

var virtual_bodies = []

# Represent a simplified body for simulation
class VirtualBody:
	var position: Vector3
	var velocity: Vector3
	var mass: float
	
	func _init(body: Node):
		position = body.global_transform.origin
		velocity = body.initalVelocity # Assuming bodies have an 'initial_velocity' property
		mass = body.get("mass") # Assuming bodies have a 'mass' property


func _ready():
	if Engine.is_editor_hint:
#		print('working')
		hide_orbits()
#		draw_orbits()
	else:
		draw_orbits()


func _process(delta):
	if Engine.is_editor_hint:
#		print('working')
		draw_orbits()


func draw_orbits():
	var bodies = get_tree().get_nodes_in_group("CelestialBody")
	virtual_bodies.clear()
	var draw_points = {}
	var reference_frame_index = 0
	var reference_body_initial_position = Vector3.ZERO

	# Initialize virtual bodies
	for i in range(bodies.size()):
		var body = bodies[i]
		virtual_bodies.append(VirtualBody.new(body))
		draw_points[body] = []

		if body == central_body and relative_to_body:
			reference_frame_index = i
			reference_body_initial_position = virtual_bodies[i].position

	# Simulate
	for step in range(num_steps):
		var reference_body_position = virtual_bodies[reference_frame_index].position if relative_to_body else Vector3.ZERO
		# Update velocities
		for i in range(virtual_bodies.size()):
			virtual_bodies[i].velocity += calculate_acceleration(i) * time_step
		# Update positions
		for i in range(virtual_bodies.size()):
			var new_pos = virtual_bodies[i].position + virtual_bodies[i].velocity * time_step
			virtual_bodies[i].position = new_pos
			if relative_to_body:
				new_pos -= reference_body_position - reference_body_initial_position
			if relative_to_body and i == reference_frame_index:
				new_pos = reference_body_initial_position

			draw_points[bodies[i]].append(new_pos)
		
	# Draw paths
	for body in bodies:
		var path_color = Color.RED#body.material_override.albedo_color # Assuming MeshInstance with material_override
#		var line_renderer = body.get_node_or_null("Line2D") # Assuming Line2D node as a child of each body
	
		if use_thick_lines:
			pass
			# Assuming you have a Line3D node as a child to the body
#			var line_renderer = body.get_node("Line3D")
#			line_renderer.clear_points()
#			for point in draw_points[body]:
#				line_renderer.add_point(point)
#			line_renderer.width = width
		else:
			for i in range(draw_points[body].size() - 1):
				Draw3d.line(draw_points[body][i], draw_points[body][i + 1])
#				line_renderer.width = 2.0 # Or any other smaller value
#				line_renderer.points = draw_points[body]




func calculate_acceleration(index):
	var acceleration = Vector3.ZERO
	for j in range(virtual_bodies.size()):
		if index == j:
			continue
		var force_dir = (virtual_bodies[j].position - virtual_bodies[index].position).normalized()
		var sqr_dst = virtual_bodies[j].position.distance_squared_to(virtual_bodies[index].position)
		acceleration += force_dir * GRAVITATIONAL_CONSTANT * virtual_bodies[j].mass / sqr_dst
	return acceleration


func hide_orbits():
	var bodies = get_tree().get_nodes_in_group("CelestialBody")
	for body in bodies:
		pass
#		var line_renderer = body.get_node("Line3D")
#		line_renderer.clear_points()


func _on_validate():
	if use_physics_time_step:
		time_step = Constants.physicsTimeStep
