/**********************************************************************************************
*
*   Physac v1.1 - 2D Physics library for videogames
*
*   DESCRIPTION:
*
*   Physac is a small 2D physics engine written in pure C. The engine uses a fixed time-step thread loop
*   to simluate physics. A physics step contains the following phases: get collision information,
*   apply dynamics, collision solving and position correction. It uses a very simple struct for physic
*   bodies with a position vector to be used in any 3D rendering API.
*
*   CONFIGURATION:
*
*   #define PHYSAC_IMPLEMENTATION
*       Generates the implementation of the library into the included file.
*       If not defined, the library is in header only mode and can be included in other headers
*       or source files without problems. But only ONE file should hold the implementation.
*
*   #define PHYSAC_DEBUG
*       Show debug traces log messages about physic bodies creation/destruction, physic system errors,
*       some calculations results and NULL reference exceptions.
*
*   #define PHYSAC_AVOID_TIMMING_SYSTEM
*       Disables internal timming system, used by UpdatePhysics() to launch timmed physic steps,
*       it allows just running UpdatePhysics() automatically on a separate thread at a desired time step.
*       In case physics steps update needs to be controlled by user with a custom timming mechanism,
*       just define this flag and the internal timming mechanism will be avoided, in that case,
*       timming libraries are neither required by the module.
*
*   #define PHYSAC_MALLOC()
*   #define PHYSAC_CALLOC()
*   #define PHYSAC_FREE()
*       You can define your own malloc/free implementation replacing stdlib.h malloc()/free() functions.
*       Otherwise it will include stdlib.h and use the C standard library malloc()/free() function.
*
*   COMPILATION:
*
*   Use the following code to compile with GCC:
*       gcc -o $(NAME_PART).exe $(FILE_NAME) -s -static -lraylib -lopengl32 -lgdi32 -lwinmm -std=c99
*
*   VERSIONS HISTORY:
*       1.1 (20-Jan-2021) @raysan5: Library general revision 
*               Removed threading system (up to the user)
*               Support MSVC C++ compilation using CLITERAL()
*               Review DEBUG mechanism for TRACELOG() and all TRACELOG() messages
*               Review internal variables/functions naming for consistency
*               Allow option to avoid internal timming system, to allow app manage the steps
*       1.0 (12-Jun-2017) First release of the library
*
*
*   LICENSE: zlib/libpng
*
*   Copyright (c) 2016-2021 Victor Fisac (@victorfisac) and Ramon Santamaria (@raysan5)
*
*   This software is provided "as-is", without any express or implied warranty. In no event
*   will the authors be held liable for any damages arising from the use of this software.
*
*   Permission is granted to anyone to use this software for any purpose, including commercial
*   applications, and to alter it and redistribute it freely, subject to the following restrictions:
*
*     1. The origin of this software must not be misrepresented; you must not claim that you
*     wrote the original software. If you use this software in a product, an acknowledgment
*     in the product documentation would be appreciated but is not required.
*
*     2. Altered source versions must be plainly marked as such, and must not be misrepresented
*     as being the original software.
*
*     3. This notice may not be removed or altered from any source distribution.
*
**********************************************************************************************/

using System;

namespace Raylib.Physac
{
	static
	{
		public const int32 MAX_BODIES = 64;
		public const int32 MAX_MANIFOLDS = 4096;
		public const int32 MAX_VERTICES = 24;
		public const int32 DEFAULT_CIRCLE_VERTICES = 24;

		public const int32 COLLISION_ITERATIONS = 100;
		public const float PENETRATION_ALLOWANCE = 0.05f;
		public const float PENETRATION_CORRECTION = 0.4f;
	}

	enum ShapeType : int32
	{
		CIRCLE = 0,
		POLYGON,
	}

	typealias Body = BodyData*;

	// Matrix2x2 type (used for polygon shape rotation matrix)
	[CRepr]
	struct Matrix2x2
	{
		public float m00;
		public float m01;
		public float m10;
		public float m11;
	}

	[CRepr]
	struct VertexData {
		public uint32 vertexCount;                   // Vertex count (positions and normals)
	    public Vector2[MAX_VERTICES] positions;     // Vertex positions vectors
	    public Vector2[MAX_VERTICES] normals;       // Vertex normals vectors
	}

	[CRepr]
	struct Shape {
	    public ShapeType type;                      // Shape type (circle or polygon)
	    public Body body;                           // Shape physics body data pointer
	    public VertexData vertexData;               // Shape vertices data (used for polygon shapes)
	    public float radius;                               // Shape radius (used for circle shapes)
	    public Matrix2x2 transform;                        // Vertices transform matrix 2x2
	}

	[CRepr]
	struct BodyData {
	    public uint32 id;                            // Unique identifier
	    public bool enabled;                               // Enabled dynamics state (collisions are calculated anyway)
	    public Vector2 position;                           // Physics body shape pivot
	    public Vector2 velocity;                           // Current linear velocity applied to position
	    public Vector2 force;                              // Current linear force (reset to 0 every step)
	    public float angularVelocity;                      // Current angular velocity applied to orient
	    public float torque;                               // Current angular force (reset to 0 every step)
	    public float orient;                               // Rotation in radians
	    public float inertia;                              // Moment of inertia
	    public float inverseInertia;                       // Inverse value of inertia
	    public float mass;                                 // Physics body mass
	    public float inverseMass;                          // Inverse value of mass
	    public float staticFriction;                       // Friction when the body has not movement (0 to 1)
	    public float dynamicFriction;                      // Friction when the body has movement (0 to 1)
	    public float restitution;                          // Restitution coefficient of the body (0 to 1)
	    public bool useGravity;                            // Apply gravity force to dynamics
	    public bool isGrounded;                            // Physics grounded on other body state
	    public bool freezeOrient;                          // Physics rotation constraint
	    public Shape shape;                         // Physics body shape information (type, radius, vertices, transform)
	}

	[CRepr]
	struct ManifoldData {
	    public uint32 id;                            // Unique identifier
	    public Body bodyA;                          // Manifold first physics body reference
		public Body bodyB;                          // Manifold second physics body reference
	    public float penetration;                          // Depth of penetration from collision
	    public Vector2 normal;                             // Normal direction vector from 'a' to 'b'
	    public Vector2[2] contacts;                        // Points of contact during collision
	    public uint32 contactsCount;                 // Current collision number of contacts
	    public float restitution;                          // Mixed restitution during collision
	    public float dynamicFriction;                      // Mixed dynamic friction during collision
	    public float staticFriction;                       // Mixed static friction during collision
	}
	typealias Manifold = ManifoldData*;

	static
	{
		// Physics system management
		[LinkName("InitPhysics")]
		public static extern void Init();                                                                           // Initializes physics system
		[LinkName("UpdatePhysics")]
		public static extern void Update();                                                                         // Update physics system
		[LinkName("ResetPhysics")]
		public static extern void Reset();                                                                          // Reset physics system (global variables)
		[LinkName("ClosePhysics")]
		public static extern void Close();                                                                          // Close physics system and unload used memory
		[LinkName("SetPhysicsTimeStep")]
		public static extern void SetTimeStep(double delta);                                                            // Sets physics fixed time step in milliseconds. 1.666666 by default
		[LinkName("SetPhysicsGravity")]
		public static extern void SetGravity(float x, float y);                                                         // Sets physics global gravity force

		// Physic body creation/destroy
		[LinkName("CreatePhysicsBodyCircle")]
		public static extern Body CreateBodyCircle(Vector2 pos, float radius, float density);                    // Creates a new circle physics body with generic parameters
		[LinkName("CreatePhysicsBodyRectangle")]
		public static extern Body CreateBodyRectangle(Vector2 pos, float width, float height, float density);    // Creates a new rectangle physics body with generic parameters
		[LinkName("CreatePhysicsBodyPolygon")]
		public static extern Body CreateBodyPolygon(Vector2 pos, float radius, int32 sides, float density);        // Creates a new polygon physics body with generic parameters
		[LinkName("DestroyPhysicsBody")]
		public static extern void DestroyBody(Body body);                                                        // Destroy a physics body

		// Physic body forces
		[LinkName("PhysicsAddForce")]
		public static extern void AddForce(Body body, Vector2 force);                                            // Adds a force to a physics body
		[LinkName("PhysicsAddTorque")]
		public static extern void AddTorque(Body body, float amount);                                            // Adds an angular force to a physics body
		[LinkName("PhysicsShatter")]
		public static extern void Shatter(Body body, Vector2 position, float force);                             // Shatters a polygon shape physics body to little physics bodies with explosion force
		[LinkName("SetPhysicsBodyRotation")]
		public static extern void SetBodyRotation(Body body, float radians);                                     // Sets physics body shape transform based on radians parameter

		// Query physics info
		[LinkName("GetPhysicsBody")]
		public static extern Body GetBody(int32 index);                                                            // Returns a physics body of the bodies pool at a specific index
		[LinkName("GetPhysicsBodiesCount")]
		public static extern int32 GetBodiesCount();                                                                  // Returns the current amount of created physics bodies
		[LinkName("GetPhysicsShapeType")]
		public static extern int32 GetShapeType(int32 index);                                                               // Returns the physics body shape type (PHYSICS_CIRCLE or PHYSICS_POLYGON)
		[LinkName("GetPhysicsShapeVerticesCount")]
		public static extern int32 GetShapeVerticesCount(int32 index);                                                      // Returns the amount of vertices of a physics body shape
		[LinkName("GetPhysicsShapeVertex")]
		public static extern Vector2 GetShapeVertex(Body body, int32 vertex); 
	}
}