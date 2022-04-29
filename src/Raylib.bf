/**********************************************************************************************
*
*   raylib v4.0 - A simple and easy-to-use library to enjoy videogames programming (www.raylib.com)
*
*   FEATURES:
*       - NO external dependencies, all required libraries included with raylib
*       - Multiplatform: Windows, Linux, FreeBSD, OpenBSD, NetBSD, DragonFly,
*                        MacOS, Haiku, Android, Raspberry Pi, DRM native, HTML5.
*       - Written in plain C code (C99) in PascalCase/camelCase notation
*       - Hardware accelerated with OpenGL (1.1, 2.1, 3.3, 4.3 or ES2 - choose at compile)
*       - Unique OpenGL abstraction layer (usable as standalone module): [rlgl]
*       - Multiple Fonts formats supported (TTF, XNA fonts, AngelCode fonts)
*       - Outstanding texture formats support, including compressed formats (DXT, ETC, ASTC)
*       - Full 3d support for 3d Shapes, Models, Billboards, Heightmaps and more!
*       - Flexible Materials system, supporting classic maps and PBR maps
*       - Animated 3D models supported (skeletal bones animation) (IQM)
*       - Shaders support, including Model shaders and Postprocessing shaders
*       - Powerful math module for Vector, Matrix and Quaternion operations: [raymath]
*       - Audio loading and playing with streaming support (WAV, OGG, MP3, FLAC, XM, MOD)
*       - VR stereo rendering with configurable HMD device parameters
*       - Bindings to multiple programming languages available!
*
*   NOTES:
*       - One default Font is loaded on InitWindow()->LoadFontDefault() [core, text]
*       - One default Texture2D is loaded on rlglInit(), 1x1 white pixel R8G8B8A8 [rlgl] (OpenGL 3.3 or ES2)
*       - One default Shader is loaded on rlglInit()->rlLoadShaderDefault() [rlgl] (OpenGL 3.3 or ES2)
*       - One default RenderBatch is loaded on rlglInit()->rlLoadRenderBatch() [rlgl] (OpenGL 3.3 or ES2)
*
*   DEPENDENCIES (included):
*       [rcore] rglfw (Camilla Löwy - github.com/glfw/glfw) for window/context management and input (PLATFORM_DESKTOP)
*       [rlgl] glad (David Herberth - github.com/Dav1dde/glad) for OpenGL 3.3 extensions loading (PLATFORM_DESKTOP)
*       [raudio] miniaudio (David Reid - github.com/mackron/miniaudio) for audio device/context management
*
*   OPTIONAL DEPENDENCIES (included):
*       [rcore] msf_gif (Miles Fogle) for GIF recording
*       [rcore] sinfl (Micha Mettke) for DEFLATE decompression algorythm
*       [rcore] sdefl (Micha Mettke) for DEFLATE compression algorythm
*       [rtextures] stb_image (Sean Barret) for images loading (BMP, TGA, PNG, JPEG, HDR...)
*       [rtextures] stb_image_write (Sean Barret) for image writing (BMP, TGA, PNG, JPG)
*       [rtextures] stb_image_resize (Sean Barret) for image resizing algorithms
*       [rtext] stb_truetype (Sean Barret) for ttf fonts loading
*       [rtext] stb_rect_pack (Sean Barret) for rectangles packing
*       [rmodels] par_shapes (Philip Rideout) for parametric 3d shapes generation
*       [rmodels] tinyobj_loader_c (Syoyo Fujita) for models loading (OBJ, MTL)
*       [rmodels] cgltf (Johannes Kuhlmann) for models loading (glTF)
*       [raudio] dr_wav (David Reid) for WAV audio file loading
*       [raudio] dr_flac (David Reid) for FLAC audio file loading
*       [raudio] dr_mp3 (David Reid) for MP3 audio file loading
*       [raudio] stb_vorbis (Sean Barret) for OGG audio loading
*       [raudio] jar_xm (Joshua Reisenauer) for XM audio module loading
*       [raudio] jar_mod (Joshua Reisenauer) for MOD audio module loading
*
*
*   LICENSE: zlib/libpng
*
*   raylib is licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software:
*
*   Copyright (c) 2013-2021 Ramon Santamaria (@raysan5)
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
using System.Diagnostics;

namespace Raylib
{
	static
	{
		//----------------------------------------------------------------------------------
		// Some basic Defines
		//----------------------------------------------------------------------------------
		public const char8* VERSION = "4.0";
		public const float PI = 3.14159265358979323846f;
		public const float DEG2RAD = PI / 180.0f;
		public const float RAD2DEG = 180.0f / PI;

		// Some Basic Colors
		// NOTE: Custom raylib color palette for amazing visuals on WHITE background
		public const Color LIGHTGRAY = .(200, 200, 200, 255);	// Light Gray
		public const Color GRAY = .(130, 130, 130, 255);		// Gray
		public const Color DARKGRAY = .(80, 80, 80, 255);		// Dark Gray
		public const Color YELLOW = .(253, 249, 0, 255);		// Yellow
		public const Color GOLD = .(255, 203, 0, 255);			// Gold
		public const Color ORANGE = .(255, 161, 0, 255);		// Orange
		public const Color PINK = .(255, 109, 194, 255);		// Pink
		public const Color RED = .(230, 41, 55, 255);			// Red
		public const Color MAROON = .(190, 33, 55, 255);		// Maroon
		public const Color GREEN = .(0, 228, 48, 255);			// Green
		public const Color LIME = .(0, 158, 47, 255);			// Lime
		public const Color DARKGREEN = .(0, 117, 44, 255);		// Dark Green
		public const Color SKYBLUE = .(102, 191, 255, 255);	// Sky Blue
		public const Color BLUE = .(0, 121, 241, 255);			// Blue
		public const Color DARKBLUE = .(0, 82, 172, 255);		// Dark Blue
		public const Color PURPLE = .(200, 122, 255, 255);		// Purple
		public const Color VIOLET = .(135, 60, 190, 255);		// Violet
		public const Color DARKPURPLE = .(112, 31, 126, 255);  // Dark Purple
		public const Color BEIGE = .(211, 176, 131, 255);		// Beige
		public const Color BROWN = .(127, 106, 79, 255);		// Brown
		public const Color DARKBROWN = .(76, 63, 47, 255);		// Dark Brown

		public const Color WHITE = .(255, 255, 255, 255);		// White
		public const Color BLACK = .(0, 0, 0, 255);			// Black
		public const Color BLANK = .(0, 0, 0, 0);				// Blank (Transparent)
		public const Color MAGENTA = .(255, 0, 255, 255);		// Magenta
		public const Color RAYWHITE = .(245, 245, 245, 255);	// My own White (raylib logo)
	}

	[CRepr]
	struct Vector2
	{
		public float x;
		public float y;

		public float u
		{
			get
			{
				return x;
			}
			set mut
			{
				x = value;
			}
		}

		public float v
		{
			get
			{
				return y;
			}
			set mut
			{
				y = value;
			}
		}

		public float left
		{
			get
			{
				return x;
			}
			set mut
			{
				x = value;
			}
		}

		public float right
		{
			get
			{
				return y;
			}
			set mut
			{
				y = value;
			}
		}

		public float this[int index]
		{
			get
			{
				if (index == 0)
				{
					return x;
				}
				else if (index == 1)
				{
					return y;
				}
				else
				{
					Debug.Assert(false);
					return 0; // NOTE(pJotoro): We just do this to remove the warning.
				}
			}
			set mut
			{
				if (index == 0)
				{
					x = value;
				}
				else if (index == 1)
				{
					y = value;
				}
				else
				{
					Debug.Assert(false);
				}
			}
		}

		public this()
		{
			x = 0;
			y = 0;
		}

		public this(float _x, float _y)
		{
			x = _x;
			y = _y;
		}
		
		// Vector with components value 0.0f
		public static Vector2 Zero
		{
			get
			{
				Vector2 v;
				v.x = 0;
				v.y = 0;
				return v;
			}
		}

		// Vector with components value 1.0f
		public static Vector2 One
		{
			get
			{
				Vector2 v;
				v.x = 1;
				v.y = 1;
				return v;
			}
		}

		// Add two vectors (v1 + v2)
		public static Vector2 operator+(Vector2 v1, Vector2 v2)
		{
			Vector2 v3;
			v3.x = v1.x + v2.x;
			v3.y = v1.y + v2.y;
			return v3;
		}

		// Add two vectors (v1 + v2)
		public void operator+=(Vector2 v) mut
		{
			x += v.x;
			y += v.y;
		}

		// Add vector and float value
		[Commutable]
		public static Vector2 operator+(Vector2 v1, float add)
		{
			Vector2 v2;
			v2.x = v1.x + add;
			v2.y = v1.y + add;
			return v2;
		}

		// Add vector and float value
		public void operator+=(float add) mut
		{
			x += add;
			y += add;
		}

		// Subtract two vectors (v1 - v2)
		public static Vector2 operator-(Vector2 v1, Vector2 v2)
		{
			Vector2 v3;
			v3.x = v1.x - v2.x;
			v3.y = v1.y - v2.y;
			return v3;
		}

		// Subtract two vectors (v1 - v2)
		public void operator-=(Vector2 v) mut
		{
			x -= v.x;
			y -= v.y;
		}

		// Subtract vector by float value
		public static Vector2 operator-(Vector2 v1, float sub)
		{
			Vector2 v2;
			v2.x = v1.x - sub;
			v2.y = v1.y - sub;
			return v2;
		}

		// Subtract vector by float value
		public void operator-=(float sub) mut
		{
			x -= sub;
			y -= sub;
		}

		// Calculate vector length
		public float Length
		{
			get
			{
				return Math.Sqrt((x*x) + (y*y));
			}
		}

		// Calculate vector square length
		public float LengthSqr
		{
			get
			{
				return (x*x) + (y*y);
			}
		}

		// Calculate two vectors dot product
		public static float DotProduct(Vector2 v1, Vector2 v2)
		{
			float result = (v1.x*v2.x + v1.y*v2.y);

			return result;
		}

		// Calculate distance between two vectors
		public static float Distance(Vector2 v1, Vector2 v2)
		{
			float result = Math.Sqrt((v1.x - v2.x)*(v1.x - v2.x) + (v1.y - v2.y)*(v1.y - v2.y));

			return result;
		}

		// Calculate angle from two vectors in X-axis
		public static float Angle(Vector2 v1, Vector2 v2)
		{
			float result = Math.Atan2(v2.y - v1.y, v2.x - v1.x)*(180.0f/PI);

			if (result < 0) result += 360.0f;

			return result;
		}

		// Scale vector (multiply by value)
		[Commutable]
		public static Vector2 operator*(Vector2 v, float scale)
		{
			return .(v.x * scale, v.y * scale);
		}

		// Scale vector (multiply by value)
		public void operator*=(float scale) mut
		{
			x *= scale;
			y *= scale;
		}

		// Multiply vector by vector
		public static Vector2 operator*(Vector2 v1, Vector2 v2)
		{
			Vector2 result = .(v1.x*v2.x, v1.y*v2.y);

			return result;
		}

		// Multiply vector by vector
		public void operator*=(Vector2 v) mut
		{
			x *= v.x;
			y *= v.y;
		}

		public static Vector2 Negate(Vector2 v)
		{
			Vector2 result = .(-v.x, -v.y);

			return result;
		}

		// Divide vector by vector
		public static Vector2 operator/(Vector2 v1, Vector2 v2)
		{
			Vector2 result = .(v1.x/v2.x, v1.y/v2.y);

			return result;
		}

		// Divide vector by vector
		public void operator/=(Vector2 v) mut
		{
			x /= v.x;
			y /= v.y;
		}

		// Normalize provided vector
		public static Vector2 Normalize(Vector2 v)
		{
			Vector2 result = Vector2.Zero;
			float length = Math.Sqrt((v.x*v.x) + (v.y*v.y));

			if (length > 0)
			{
			    result.x = v.x*1.0f/length;
			    result.y = v.y*1.0f/length;
			}

			return result;
		}

		// Calculate linear interpolation between two vectors
		public static Vector2 Lerp(Vector2 v1, Vector2 v2, float amount)
		{
			Vector2 result = Vector2.Zero;

			result.x = v1.x + amount*(v2.x - v1.x);
			result.y = v1.y + amount*(v2.y - v1.y);

			return result;
		}

		// Calculate reflected vector to normal
		public static Vector2 Reflect(Vector2 v, Vector2 normal)
		{
			Vector2 result = Vector2.Zero;

			float dotProduct = (v.x*normal.x + v.y*normal.y); // Dot product

			result.x = v.x - (2.0f*normal.x)*dotProduct;
			result.y = v.y - (2.0f*normal.y)*dotProduct;

			return result;
		}

		// Rotate vector by angle
		public static Vector2 Vector2Rotate(Vector2 v, float angle)
		{
		    Vector2 result = Vector2.Zero;

		    result.x = v.x*Math.Cos(angle) - v.y*Math.Sin(angle);
		    result.y = v.x*Math.Sin(angle) + v.y*Math.Cos(angle);

		    return result;
		}

		// Move Vector towards target
		public static Vector2 Vector2MoveTowards(Vector2 v, Vector2 target, float maxDistance)
		{
		    Vector2 result = Vector2.Zero;

		    float dx = target.x - v.x;
		    float dy = target.y - v.y;
		    float value = (dx*dx) + (dy*dy);

		    if ((value == 0) || ((maxDistance >= 0) && (value <= maxDistance*maxDistance))) return target;

		    float dist = Math.Sqrt(value);

		    result.x = v.x + dx/dist*maxDistance;
		    result.y = v.y + dy/dist*maxDistance;

		    return result;
		}
	}

	[CRepr]
	struct Vector3
	{
		public float x;
		public float y;
		public float z;

		public float u
		{
			get
			{
				return x;
			}
			set mut
			{
				x = value;
			}
		}

		public float v
		{
			get
			{
				return y;
			}
			set mut
			{
				y = value;
			}
		}

		public float w
		{
			get
			{
				return z;
			}
			set mut
			{
				z = value;
			}
		}

		public float r
		{
			get
			{
				return x;
			}
			set mut
			{
				x = value;
			}
		}

		public float g
		{
			get
			{
				return y;
			}
			set mut
			{
				y = value;
			}
		}

		public float b
		{
			get
			{
				return z;
			}
			set mut
			{
				z = value;
			}
		}

		public float this[int index]
		{
			get
			{
				if (index == 0)
				{
					return x;
				}
				else if (index == 1)
				{
					return y;
				}
				else if (index == 2)
				{
					return z;
				}
				else
				{
					Debug.Assert(false);
					return 0; // NOTE(pJotoro): We just do this to remove the warning.
				}
			}
			set mut
			{
				if (index == 0)
				{
					x = value;
				}
				else if (index == 1)
				{
					y = value;
				}
				else if (index == 2)
				{
					z = value;
				}
				else
				{
					Debug.Assert(false);
				}
			}
		}

		public this()
		{
			x = 0;
			y = 0;
			z = 0;
		}

		public this(float _x, float _y, float _z)
		{
			x = _x;
			y = _y;
			z = _z;
		}

		// Vector with components value 0.0f
		public static Vector3 Zero
		{
			get
			{
				return .(0, 0, 0);
			}
		}

		// Vector with components value 1.0f
		public static Vector3 One
		{
			get
			{
				return .(1, 1, 1);
			}
		}

		// Add two vectors
		public static Vector3 operator+(Vector3 v1, Vector3 v2)
		{
			Vector3 v3;
			v3.x = v1.x + v2.x;
			v3.y = v1.y + v2.y;
			v3.z = v1.z + v2.z;
			return v3;
		}

		// Add two vectors
		public void operator+=(Vector3 v) mut
		{
			x += v.x;
			y += v.y;
			z += v.z;
		}

		// Add vector and float value
		[Commutable]
		public static Vector3 operator+(Vector3 v, float add)
		{
			Vector3 result = .(v.x + add, v.y + add, v.z + add);
			return result;
		}

		// Add vector and float value
		public void operator+=(float add) mut
		{
			x += add;
			y += add;
			z += add;
		}

		// Subtract two vectors
		public static Vector3 operator-(Vector3 v1, Vector3 v2)
		{
			return .(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
		}

		// Subtract two vectors
		public void operator-=(Vector3 v) mut
		{
			x -= v.x;
			y -= v.y;
			z -= v.z;
		}

		// Subtract vector by float value
		public static Vector3 operator-(Vector3 v, float sub)
		{
			Vector3 result = .(v.x - sub, v.y - sub, v.z - sub);
			return result;
		}

		// Subtract vector by float value
		public void operator-=(float sub) mut
		{
			x -= sub;
			y -= sub;
			z -= sub;
		}

		// Multiply vector by scalar
		[Commutable]
		public static Vector3 operator*(Vector3 v, float scalar)
		{
			return .(v.x * scalar, v.y * scalar, v.z * scalar);
		}

		// Multiply vector by scalar
		public void operator*=(float scalar) mut
		{
			x *= scalar;
			y *= scalar;
			z *= scalar;
		}

		// Multiply vector by vector
		public static Vector3 operator*(Vector3 v1, Vector3 v2)
		{
			return .(v1.x * v2.x, v1.y * v2.y, v1.z * v2.z);
		}

		// Multiply vector by vector
		public void operator*=(Vector3 v) mut
		{
			x *= v.x;
			y *= v.y;
			z *= v.z;
		}

		// Calculate two vectors cross product
		public static Vector3 CrossProduct(Vector3 v1, Vector3 v2)
		{
			Vector3 result = .(v1.y*v2.z - v1.z*v2.y, v1.z*v2.x - v1.x*v2.z, v1.x*v2.y - v1.y*v2.x);

			return result;
		}

		// Calculate one vector perpendicular vector
		public static Vector3 Perpendicular(Vector3 v)
		{
			Vector3 result = Vector3.Zero;

			float min = (float) Math.Abs(v.x);
			Vector3 cardinalAxis = .(1.0f, 0.0f, 0.0f);

			if (Math.Abs(v.y) < min)
			{
			    min = (float) Math.Abs(v.y);
			    Vector3 tmp = .(0.0f, 1.0f, 0.0f);
			    cardinalAxis = tmp;
			}

			if (Math.Abs(v.z) < min)
			{
			    Vector3 tmp = .(0.0f, 0.0f, 1.0f);
			    cardinalAxis = tmp;
			}

			// Cross product between vectors
			result.x = v.y*cardinalAxis.z - v.z*cardinalAxis.y;
			result.y = v.z*cardinalAxis.x - v.x*cardinalAxis.z;
			result.z = v.x*cardinalAxis.y - v.y*cardinalAxis.x;

			return result;
		}

		// Calculate vector length
		public float Length
		{
			get
			{
				float result = Math.Sqrt(x*x + y*y + z*z);

				return result;
			}
		}

		// Calculate vector square length
		public float LengthSqr
		{
			get
			{
				float result = x*x + y*y + z*z;

				return result;
			}
		}

		// Calculate two vectors dot product
		public static float DotProduct(Vector3 v1, Vector3 v2)
		{
			float result = (v1.x*v2.x + v1.y*v2.y + v1.z*v2.z);

			return result;
		}

		// Calculate distance between two vectors
		public static float Distance(Vector3 v1, Vector3 v2)
		{
			float result = 0.0f;

			float dx = v2.x - v1.x;
			float dy = v2.y - v1.y;
			float dz = v2.z - v1.z;
			result = Math.Sqrt(dx*dx + dy*dy + dz*dz);

			return result;
		}

		// Calculate angle between two vectors in XY and XZ
		public static Vector2 Angle(Vector3 v1, Vector3 v2)
		{
		    Vector2 result = Vector2.Zero;

		    float dx = v2.x - v1.x;
		    float dy = v2.y - v1.y;
		    float dz = v2.z - v1.z;

		    result.x = Math.Atan2(dx, dz);                      // Angle in XZ
		    result.y = Math.Atan2(dy, Math.Sqrt(dx*dx + dz*dz));    // Angle in XY

		    return result;
		}

		// Negate provided vector (invert direction)
		public static Vector3 Negate(Vector3 v)
		{
		    Vector3 result = .(-v.x, -v.y, -v.z);

		    return result;
		}

		// Divide vector by vector
		public static Vector3 operator/(Vector3 v1, Vector3 v2)
		{
			return .(v1.x/v2.x, v1.y/v2.y, v1.z/v2.z);
		}

		// Normalize provided vector
		public static Vector3 Normalize(Vector3 v)
		{
		    Vector3 result = v;

		    float length = Math.Sqrt(v.x*v.x + v.y*v.y + v.z*v.z);
		    if (length == 0.0f) length = 1.0f;
		    float ilength = 1.0f/length;

		    result.x *= ilength;
		    result.y *= ilength;
		    result.z *= ilength;

		    return result;
		}

		// Orthonormalize provided vectors
		// Makes vectors normalized and orthogonal to each other
		// Gram-Schmidt function implementation
		public static void OrthoNormalize(ref Vector3 v1, ref Vector3 v2)
		{
		    float length = 0.0f;
		    float ilength = 0.0f;

		    // Vector3Normalize(v1);
		    Vector3 v = v1;
		    length = Math.Sqrt(v.x*v.x + v.y*v.y + v.z*v.z);
		    if (length == 0.0f) length = 1.0f;
		    ilength = 1.0f/length;
		    v1.x *= ilength;
		    v1.y *= ilength;
		    v1.z *= ilength;

		    // Vector3.CrossProduct(v1, v2)
		    Vector3 vn1 = .(v1.y*v2.z - v1.z*v2.y, v1.z*v2.x - v1.x*v2.z, v1.x*v2.y - v1.y*v2.x);

		    // Vector3Normalize(vn1);
		    v = vn1;
		    length = Math.Sqrt(v.x*v.x + v.y*v.y + v.z*v.z);
		    if (length == 0.0f) length = 1.0f;
		    ilength = 1.0f/length;
		    vn1.x *= ilength;
		    vn1.y *= ilength;
		    vn1.z *= ilength;

		    // Vector3CrossProduct(vn1, v1)
		    Vector3 vn2 = .(vn1.y*v1.z - vn1.z*v1.y, vn1.z*v1.x - vn1.x*v1.z, vn1.x*v1.y - vn1.y*v1.x);

		    v2 = vn2;
		}

		// Transforms a Vector3 by a given Matrix
		public static Vector3 Transform(Vector3 v, Matrix mat)
		{
		    Vector3 result = Vector3.Zero;

		    float x = v.x;
		    float y = v.y;
		    float z = v.z;

		    result.x = mat.m0*x + mat.m4*y + mat.m8*z + mat.m12;
		    result.y = mat.m1*x + mat.m5*y + mat.m9*z + mat.m13;
		    result.z = mat.m2*x + mat.m6*y + mat.m10*z + mat.m14;

		    return result;
		}

		// Transform a vector by quaternion rotation
		public static Vector3 RotateByQuaternion(Vector3 v, Quaternion q)
		{
		    Vector3 result = Vector3.Zero;

		    result.x = v.x*(q.x*q.x + q.w*q.w - q.y*q.y - q.z*q.z) + v.y*(2*q.x*q.y - 2*q.w*q.z) + v.z*(2*q.x*q.z + 2*q.w*q.y);
		    result.y = v.x*(2*q.w*q.z + 2*q.x*q.y) + v.y*(q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z) + v.z*(-2*q.w*q.x + 2*q.y*q.z);
		    result.z = v.x*(-2*q.w*q.y + 2*q.x*q.z) + v.y*(2*q.w*q.x + 2*q.y*q.z)+ v.z*(q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z);

		    return result;
		}

		// Calculate linear interpolation between two vectors
		public static Vector3 Lerp(Vector3 v1, Vector3 v2, float amount)
		{
		    Vector3 result = Vector3.Zero;

		    result.x = v1.x + amount*(v2.x - v1.x);
		    result.y = v1.y + amount*(v2.y - v1.y);
		    result.z = v1.z + amount*(v2.z - v1.z);

		    return result;
		}

		// Calculate reflected vector to normal
		public static Vector3 Reflect(Vector3 v, Vector3 normal)
		{
		    Vector3 result = Vector3.Zero;

		    // I is the original vector
		    // N is the normal of the incident plane
		    // R = I - (2*N*(DotProduct[I, N]))

		    float dotProduct = (v.x*normal.x + v.y*normal.y + v.z*normal.z);

		    result.x = v.x - (2.0f*normal.x)*dotProduct;
		    result.y = v.y - (2.0f*normal.y)*dotProduct;
		    result.z = v.z - (2.0f*normal.z)*dotProduct;

		    return result;
		}

		// Get min value for each pair of components
		public static Vector3 Min(Vector3 v1, Vector3 v2)
		{
		    Vector3 result = Vector3.Zero;

		    result.x = Math.Min(v1.x, v2.x);
		    result.y = Math.Min(v1.y, v2.y);
		    result.z = Math.Min(v1.z, v2.z);

		    return result;
		}

		// Get max value for each pair of components
		public static Vector3 Max(Vector3 v1, Vector3 v2)
		{
		    Vector3 result = Vector3.Zero;

		    result.x = Math.Max(v1.x, v2.x);
		    result.y = Math.Max(v1.y, v2.y);
		    result.z = Math.Max(v1.z, v2.z);

		    return result;
		}

		// Compute barycenter coordinates (u, v, w) for point p with respect to triangle (a, b, c)
		// NOTE: Assumes P is on the plane of the triangle
		public static Vector3 Barycenter(Vector3 p, Vector3 a, Vector3 b, Vector3 c)
		{
		    Vector3 result = Vector3.Zero;

		    Vector3 v0 = .(b.x - a.x, b.y - a.y, b.z - a.z);   // Vector3Subtract(b, a)
		    Vector3 v1 = .(c.x - a.x, c.y - a.y, c.z - a.z);   // Vector3Subtract(c, a)
		    Vector3 v2 = .(p.x - a.x, p.y - a.y, p.z - a.z);   // Vector3Subtract(p, a)
		    float d00 = (v0.x*v0.x + v0.y*v0.y + v0.z*v0.z);    // Vector3DotProduct(v0, v0)
		    float d01 = (v0.x*v1.x + v0.y*v1.y + v0.z*v1.z);    // Vector3DotProduct(v0, v1)
		    float d11 = (v1.x*v1.x + v1.y*v1.y + v1.z*v1.z);    // Vector3DotProduct(v1, v1)
		    float d20 = (v2.x*v0.x + v2.y*v0.y + v2.z*v0.z);    // Vector3DotProduct(v2, v0)
		    float d21 = (v2.x*v1.x + v2.y*v1.y + v2.z*v1.z);    // Vector3DotProduct(v2, v1)

		    float denom = d00*d11 - d01*d01;

		    result.y = (d11*d20 - d01*d21)/denom;
		    result.z = (d00*d21 - d01*d20)/denom;
		    result.x = 1.0f - (result.z + result.y);

		    return result;
		}

		// Projects a Vector3 from screen space into object space
		// NOTE: We are avoiding calling other raymath functions despite available
		public static Vector3 Unproject(Vector3 source, Matrix projection, Matrix view)
		{
		    Vector3 result = Vector3.Zero;

		    // Calculate unproject matrix (multiply view patrix by projection matrix) and invert it
		    Matrix matViewProj = .(      // MatrixMultiply(view, projection);
		        view.m0*projection.m0 + view.m1*projection.m4 + view.m2*projection.m8 + view.m3*projection.m12,
		        view.m0*projection.m1 + view.m1*projection.m5 + view.m2*projection.m9 + view.m3*projection.m13,
		        view.m0*projection.m2 + view.m1*projection.m6 + view.m2*projection.m10 + view.m3*projection.m14,
		        view.m0*projection.m3 + view.m1*projection.m7 + view.m2*projection.m11 + view.m3*projection.m15,
		        view.m4*projection.m0 + view.m5*projection.m4 + view.m6*projection.m8 + view.m7*projection.m12,
		        view.m4*projection.m1 + view.m5*projection.m5 + view.m6*projection.m9 + view.m7*projection.m13,
		        view.m4*projection.m2 + view.m5*projection.m6 + view.m6*projection.m10 + view.m7*projection.m14,
		        view.m4*projection.m3 + view.m5*projection.m7 + view.m6*projection.m11 + view.m7*projection.m15,
		        view.m8*projection.m0 + view.m9*projection.m4 + view.m10*projection.m8 + view.m11*projection.m12,
		        view.m8*projection.m1 + view.m9*projection.m5 + view.m10*projection.m9 + view.m11*projection.m13,
		        view.m8*projection.m2 + view.m9*projection.m6 + view.m10*projection.m10 + view.m11*projection.m14,
		        view.m8*projection.m3 + view.m9*projection.m7 + view.m10*projection.m11 + view.m11*projection.m15,
		        view.m12*projection.m0 + view.m13*projection.m4 + view.m14*projection.m8 + view.m15*projection.m12,
		        view.m12*projection.m1 + view.m13*projection.m5 + view.m14*projection.m9 + view.m15*projection.m13,
		        view.m12*projection.m2 + view.m13*projection.m6 + view.m14*projection.m10 + view.m15*projection.m14,
		        view.m12*projection.m3 + view.m13*projection.m7 + view.m14*projection.m11 + view.m15*projection.m15);

		    // Calculate inverted matrix -> MatrixInvert(matViewProj);
		    // Cache the matrix values (speed optimization)
		    float a00 = matViewProj.m0, a01 = matViewProj.m1, a02 = matViewProj.m2, a03 = matViewProj.m3;
		    float a10 = matViewProj.m4, a11 = matViewProj.m5, a12 = matViewProj.m6, a13 = matViewProj.m7;
		    float a20 = matViewProj.m8, a21 = matViewProj.m9, a22 = matViewProj.m10, a23 = matViewProj.m11;
		    float a30 = matViewProj.m12, a31 = matViewProj.m13, a32 = matViewProj.m14, a33 = matViewProj.m15;

		    float b00 = a00*a11 - a01*a10;
		    float b01 = a00*a12 - a02*a10;
		    float b02 = a00*a13 - a03*a10;
		    float b03 = a01*a12 - a02*a11;
		    float b04 = a01*a13 - a03*a11;
		    float b05 = a02*a13 - a03*a12;
		    float b06 = a20*a31 - a21*a30;
		    float b07 = a20*a32 - a22*a30;
		    float b08 = a20*a33 - a23*a30;
		    float b09 = a21*a32 - a22*a31;
		    float b10 = a21*a33 - a23*a31;
		    float b11 = a22*a33 - a23*a32;

		    // Calculate the invert determinant (inlined to avoid double-caching)
		    float invDet = 1.0f/(b00*b11 - b01*b10 + b02*b09 + b03*b08 - b04*b07 + b05*b06);

		    Matrix matViewProjInv = .(
		        (a11*b11 - a12*b10 + a13*b09)*invDet,
		        (-a01*b11 + a02*b10 - a03*b09)*invDet,
		        (a31*b05 - a32*b04 + a33*b03)*invDet,
		        (-a21*b05 + a22*b04 - a23*b03)*invDet,
		        (-a10*b11 + a12*b08 - a13*b07)*invDet,
		        (a00*b11 - a02*b08 + a03*b07)*invDet,
		        (-a30*b05 + a32*b02 - a33*b01)*invDet,
		        (a20*b05 - a22*b02 + a23*b01)*invDet,
		        (a10*b10 - a11*b08 + a13*b06)*invDet,
		        (-a00*b10 + a01*b08 - a03*b06)*invDet,
		        (a30*b04 - a31*b02 + a33*b00)*invDet,
		        (-a20*b04 + a21*b02 - a23*b00)*invDet,
		        (-a10*b09 + a11*b07 - a12*b06)*invDet,
		        (a00*b09 - a01*b07 + a02*b06)*invDet,
		        (-a30*b03 + a31*b01 - a32*b00)*invDet,
		        (a20*b03 - a21*b01 + a22*b00)*invDet);

		    // Create quaternion from source point
		    Quaternion quat = .(source.x, source.y, source.z, 1.0f);

		    // Multiply quat point by unproject matrix
		    Quaternion qtransformed = .(     // QuaternionTransform(quat, matViewProjInv)
		        matViewProjInv.m0*quat.x + matViewProjInv.m4*quat.y + matViewProjInv.m8*quat.z + matViewProjInv.m12*quat.w,
		        matViewProjInv.m1*quat.x + matViewProjInv.m5*quat.y + matViewProjInv.m9*quat.z + matViewProjInv.m13*quat.w,
		        matViewProjInv.m2*quat.x + matViewProjInv.m6*quat.y + matViewProjInv.m10*quat.z + matViewProjInv.m14*quat.w,
		        matViewProjInv.m3*quat.x + matViewProjInv.m7*quat.y + matViewProjInv.m11*quat.z + matViewProjInv.m15*quat.w);

		    // Normalized world points in vectors
		    result.x = qtransformed.x/qtransformed.w;
		    result.y = qtransformed.y/qtransformed.w;
		    result.z = qtransformed.z/qtransformed.w;

		    return result;
		}

		public static float3 ToFloatV(Vector3 v)
		{
			float3 buffer = .();

			buffer.v[0] = v.x;
			buffer.v[1] = v.y;
			buffer.v[2] = v.z;

			return buffer;
		}
	}

	[CRepr]
	struct Quaternion
	{
		public float x;
		public float y;
		public float z;
		public float w;

		public this()
		{
			x = 0;
			y = 0;
			z = 0;
			w = 0;
		}

		public this(float _x, float _y, float _z, float _w)
		{
			x = _x;
			y = _y;
			z = _z;
			w = _w;
		}

		public float r
		{
			get
			{
				return x;
			}
			set mut
			{
				x = value;
			}
		}

		public float g
		{
			get
			{
				return y;
			}
			set mut
			{
				y = value;
			}
		}

		public float b
		{
			get
			{
				return z;
			}
			set mut
			{
				z = value;
			}
		}

		public float a
		{
			get
			{
				return w;
			}
			set mut
			{
				w = value;
			}
		}

		public float this[int index]
		{
			get
			{
				if (index == 0)
				{
					return x;
				}
				else if (index == 1)
				{
					return y;
				}
				else if (index == 2)
				{
					return z;
				}
				else if (index == 3)
				{
					return w;
				}
				else
				{
					Debug.Assert(false);
					return 0; // NOTE(pJotoro): We just do this to remove the warning.
				}
			}
			set mut
			{
				if (index == 0)
				{
					x = value;
				}
				else if (index == 1)
				{
					y = value;
				}
				else if (index == 2)
				{
					z = value;
				}
				else if (index == 3)
				{
					w = value;
				}
				else
				{
					Debug.Assert(false);
				}
			}
		}

		// Add two quaternions
		public static Quaternion operator+(Quaternion q1, Quaternion q2)
		{
			return .(q1.x + q2.x, q1.y + q2.y, q1.z + q2.z, q1.w + q2.w);
		}

		// Add two quaternions
		public void operator+=(Quaternion q) mut
		{
			x += q.x;
			y += q.y;
			z += q.z;
			w += q.w;
		}

		// Add quaternion and float value
		[Commutable]
		public static Quaternion operator+(Quaternion q, float add)
		{
			return .(q.x + add, q.y + add, q.z + add, q.w + add);
		}

		// Add quaternion and float value
		public void operator+=(float add) mut
		{
			x += add;
			y += add;
			z += add;
			w += add;
		}

		// Subtract two quaternions
		public static Quaternion operator-(Quaternion q1, Quaternion q2)
		{
			return .(q1.x - q2.x, q1.y - q2.y, q1.z - q2.z, q1.w - q2.w);
		}

		// Subtract two quaternions
		public void operator-=(Quaternion q) mut
		{
			x -= q.x;
			y -= q.y;
			z -= q.z;
			w -= q.w;
		}

		// Subtract quaternion and float value
		public static Quaternion operator-(Quaternion q, float sub)
		{
			return .(q.x - sub, q.y - sub, q.z - sub, q.w - sub);
		}

		// Subtract quaternion and float value
		public void operator-=(float sub) mut
		{
			x -= sub;
			y -= sub;
			z -= sub;
			w -= sub;
		}

		public static Quaternion Identity
		{
			get
			{
				return .(0.0f, 0.0f, 0.0f, 1.0f);
			}
		}

		public float Length
		{
			get
			{
				return Math.Sqrt(x*x + y*y + z*z + w*w);
			}
		}

		public static Quaternion Normalize(Quaternion q)
		{
			Quaternion result = .();

			float length = Math.Sqrt(q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w);
			if (length == 0.0f) length = 1.0f;
			float ilength = 1.0f/length;

			result.x = q.x*ilength;
			result.y = q.y*ilength;
			result.z = q.z*ilength;
			result.w = q.w*ilength;

			return result;
		}

		// Invert provided quaternion
		public static Quaternion Invert(Quaternion q)
		{
		    Quaternion result = q;

		    float length = Math.Sqrt(q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w);
		    float lengthSq = length*length;

		    if (lengthSq != 0.0)
		    {
		        float invLength = 1.0f/lengthSq;

		        result.x *= -invLength;
		        result.y *= -invLength;
		        result.z *= -invLength;
		        result.w *= invLength;
		    }

		    return result;
		}

		// Calculate two quaternion multiplication
		public static Quaternion operator*(Quaternion q1, Quaternion q2)
		{
			Quaternion result = .();

			float qax = q1.x, qay = q1.y, qaz = q1.z, qaw = q1.w;
			float qbx = q2.x, qby = q2.y, qbz = q2.z, qbw = q2.w;

			result.x = qax*qbw + qaw*qbx + qay*qbz - qaz*qby;
			result.y = qay*qbw + qaw*qby + qaz*qbx - qax*qbz;
			result.z = qaz*qbw + qaw*qbz + qax*qby - qay*qbx;
			result.w = qaw*qbw - qax*qbx - qay*qby - qaz*qbz;

			return result;
		}

		// Calculate two quaternion multiplication
		public void operator*=(Quaternion q) mut
		{
			Quaternion result = this;

			float qax = x, qay = y, qaz = z, qaw = w;
			float qbx = q.x, qby = q.y, qbz = q.z, qbw = q.w;

			result.x = qax*qbw + qaw*qbx + qay*qbz - qaz*qby;
			result.y = qay*qbw + qaw*qby + qaz*qbx - qax*qbz;
			result.z = qaz*qbw + qaw*qbz + qax*qby - qay*qbx;
			result.w = qaw*qbw - qax*qbx - qay*qby - qaz*qbz;

			this = result;
		}

		// Scale quaternion by float value
		[Commutable]
		public static Quaternion operator*(Quaternion q, float mul)
		{
			Quaternion result = .();

			float qax = q.x, qay = q.y, qaz = q.z, qaw = q.w;

			result.x = qax*mul + qaw*mul + qay*mul - qaz*mul;
			result.y = qay*mul + qaw*mul + qaz*mul - qax*mul;
			result.z = qaz*mul + qaw*mul + qax*mul - qay*mul;
			result.w = qaw*mul - qax*mul - qay*mul - qaz*mul;

			return result;
		}

		// Scale quaternion by float value
		public void operator*=(float mul) mut
		{
			Quaternion result = this;

			float qax = x, qay = y, qaz = z, qaw = w;

			result.x = qax*mul + qaw*mul + qay*mul - qaz*mul;
			result.y = qay*mul + qaw*mul + qaz*mul - qax*mul;
			result.z = qaz*mul + qaw*mul + qax*mul - qay*mul;
			result.w = qaw*mul - qax*mul - qay*mul - qaz*mul;

			this = result;
		}

		// Divide two quaternions
		public static Quaternion operator/(Quaternion q1, Quaternion q2)
		{
			return .(q1.x/q2.x, q1.y/q2.y, q1.z/q2.z, q1.w/q2.w);
		}

		// Divide two quaternions
		public void operator/=(Quaternion q) mut
		{
			x /= q.x;
			y /= q.y;
			z /= q.z;
			w /= q.w;
		}

		// Calculate linear interpolation between two quaternions
		public static Quaternion Lerp(Quaternion q1, Quaternion q2, float amount)
		{
		    Quaternion result = .();

		    result.x = q1.x + amount*(q2.x - q1.x);
		    result.y = q1.y + amount*(q2.y - q1.y);
		    result.z = q1.z + amount*(q2.z - q1.z);
		    result.w = q1.w + amount*(q2.w - q1.w);

		    return result;
		}

		// Calculate slerp-optimized interpolation between two quaternions
		public static Quaternion Nlerp(Quaternion q1, Quaternion q2, float amount)
		{
		    Quaternion result = .();

		    // QuaternionLerp(q1, q2, amount)
		    result.x = q1.x + amount*(q2.x - q1.x);
		    result.y = q1.y + amount*(q2.y - q1.y);
		    result.z = q1.z + amount*(q2.z - q1.z);
		    result.w = q1.w + amount*(q2.w - q1.w);

		    // QuaternionNormalize(q);
		    Quaternion q = result;
		    float length = Math.Sqrt(q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w);
		    if (length == 0.0f) length = 1.0f;
		    float ilength = 1.0f/length;

		    result.x = q.x*ilength;
		    result.y = q.y*ilength;
		    result.z = q.z*ilength;
		    result.w = q.w*ilength;

		    return result;
		}

		// Calculates spherical linear interpolation between two quaternions
		public static Quaternion Slerp(Quaternion q1, Quaternion _q2, float amount)
		{
		    Quaternion result = .();
			Quaternion q2 = _q2; // NOTE(pJotoro): It seems like C lets you set parameters like variables, unlike Beef.

		    float cosHalfTheta = q1.x*q2.x + q1.y*q2.y + q1.z*q2.z + q1.w*q2.w;

		    if (cosHalfTheta < 0)
		    {
		        q2.x = -q2.x; q2.y = -q2.y; q2.z = -q2.z; q2.w = -q2.w;
		        cosHalfTheta = -cosHalfTheta;
		    }

		    if (Math.Abs(cosHalfTheta) >= 1.0f) result = q1;
		    else if (cosHalfTheta > 0.95f) result = Quaternion.Nlerp(q1, q2, amount);
		    else
		    {
		        float halfTheta = Math.Acos(cosHalfTheta);
		        float sinHalfTheta = Math.Sqrt(1.0f - cosHalfTheta*cosHalfTheta);

		        if (Math.Abs(sinHalfTheta) < 0.001f)
		        {
		            result.x = (q1.x*0.5f + q2.x*0.5f);
		            result.y = (q1.y*0.5f + q2.y*0.5f);
		            result.z = (q1.z*0.5f + q2.z*0.5f);
		            result.w = (q1.w*0.5f + q2.w*0.5f);
		        }
		        else
		        {
		            float ratioA = Math.Sin(1 - amount)*halfTheta)/sinHalfTheta;
		            float ratioB = Math.Sin(amount*halfTheta)/sinHalfTheta;

		            result.x = (q1.x*ratioA + q2.x*ratioB);
		            result.y = (q1.y*ratioA + q2.y*ratioB);
		            result.z = (q1.z*ratioA + q2.z*ratioB);
		            result.w = (q1.w*ratioA + q2.w*ratioB);
		        }
		    }

		    return result;
		}

		// Calculate quaternion based on the rotation from one vector to another
		public static Quaternion FromVector3ToVector3(Vector3 from, Vector3 to)
		{
		    Quaternion result = .();

		    float cos2Theta = (from.x*to.x + from.y*to.y + from.z*to.z);    // Vector3DotProduct(from, to)
		    Vector3 cross = .(from.y*to.z - from.z*to.y, from.z*to.x - from.x*to.z, from.x*to.y - from.y*to.x); // Vector3CrossProduct(from, to)

		    result.x = cross.x;
		    result.y = cross.y;
		    result.z = cross.z;
		    result.w = 1.0f + cos2Theta;

		    // QuaternionNormalize(q);
		    // NOTE: Normalize to essentially nlerp the original and identity to 0.5
		    Quaternion q = result;
		    float length = Math.Sqrt(q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w);
		    if (length == 0.0f) length = 1.0f;
		    float ilength = 1.0f/length;

		    result.x = q.x*ilength;
		    result.y = q.y*ilength;
		    result.z = q.z*ilength;
		    result.w = q.w*ilength;

		    return result;
		}

		// Get a quaternion for a given rotation matrix
		public static Quaternion FromMatrix(Matrix mat)
		{
		    Quaternion result = .();

		    if ((mat.m0 > mat.m5) && (mat.m0 > mat.m10))
		    {
		        float s = Math.Sqrt(1.0f + mat.m0 - mat.m5 - mat.m10)*2;

		        result.x = 0.25f*s;
		        result.y = (mat.m4 + mat.m1)/s;
		        result.z = (mat.m2 + mat.m8)/s;
		        result.w = (mat.m9 - mat.m6)/s;
		    }
		    else if (mat.m5 > mat.m10)
		    {
		        float s = Math.Sqrt(1.0f + mat.m5 - mat.m0 - mat.m10)*2;
		        result.x = (mat.m4 + mat.m1)/s;
		        result.y = 0.25f*s;
		        result.z = (mat.m9 + mat.m6)/s;
		        result.w = (mat.m2 - mat.m8)/s;
		    }
		    else
		    {
		        float s = Math.Sqrt(1.0f + mat.m10 - mat.m0 - mat.m5)*2;
		        result.x = (mat.m2 + mat.m8)/s;
		        result.y = (mat.m9 + mat.m6)/s;
		        result.z = 0.25f*s;
		        result.w = (mat.m4 - mat.m1)/s;
		    }

		    return result;
		}

		// Get a matrix for a given quaternion
		public static Matrix ToMatrix(Quaternion q)
		{
		    Matrix result = .(1.0f, 0.0f, 0.0f, 0.0f,
		                      0.0f, 1.0f, 0.0f, 0.0f,
		                      0.0f, 0.0f, 1.0f, 0.0f,
		                      0.0f, 0.0f, 0.0f, 1.0f); // MatrixIdentity()

		    float a2 = q.x*q.x;
		    float b2 = q.y*q.y;
		    float c2 = q.z*q.z;
		    float ac = q.x*q.z;
		    float ab = q.x*q.y;
		    float bc = q.y*q.z;
		    float ad = q.w*q.x;
		    float bd = q.w*q.y;
		    float cd = q.w*q.z;

		    result.m0 = 1 - 2*(b2 + c2);
		    result.m1 = 2*(ab + cd);
		    result.m2 = 2*(ac - bd);

		    result.m4 = 2*(ab - cd);
		    result.m5 = 1 - 2*(a2 + c2);
		    result.m6 = 2*(bc + ad);

		    result.m8 = 2*(ac + bd);
		    result.m9 = 2*(bc - ad);
		    result.m10 = 1 - 2*(a2 + b2);

		    return result;
		}

		// Get rotation quaternion for an angle and axis
		// NOTE: angle must be provided in radians
		public static Quaternion FromAxisAngle(Vector3 _axis, float _angle)
		{
		    Quaternion result = .(0.0f, 0.0f, 0.0f, 1.0f);
			Vector3 axis = _axis;
			float angle = _angle;

		    float axisLength = Math.Sqrt(axis.x*axis.x + axis.y*axis.y + axis.z*axis.z);

		    if (axisLength != 0.0f)
		    {
		        angle *= 0.5f;

		        float length = 0.0f;
		        float ilength = 0.0f;

		        // Vector3Normalize(axis)
		        Vector3 v = axis;
		        length = Math.Sqrt(v.x*v.x + v.y*v.y + v.z*v.z);
		        if (length == 0.0f) length = 1.0f;
		        ilength = 1.0f/length;
		        axis.x *= ilength;
		        axis.y *= ilength;
		        axis.z *= ilength;

		        float sinres = Math.Sin(angle);
		        float cosres = Math.Cos(angle);

		        result.x = axis.x*sinres;
		        result.y = axis.y*sinres;
		        result.z = axis.z*sinres;
		        result.w = cosres;

		        // QuaternionNormalize(q);
		        Quaternion q = result;
		        length = Math.Sqrt(q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w);
		        if (length == 0.0f) length = 1.0f;
		        ilength = 1.0f/length;
		        result.x = q.x*ilength;
		        result.y = q.y*ilength;
		        result.z = q.z*ilength;
		        result.w = q.w*ilength;
		    }

		    return result;
		}

		// Get the rotation angle and axis for a given quaternion
		public static void ToAxisAngle(Quaternion _q, out Vector3 outAxis, out float outAngle)
		{
			Quaternion q = _q;

		    if (Math.Abs(q.w) > 1.0f)
		    {
		        // QuaternionNormalize(q);
		        float length = Math.Sqrt(q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w);
		        if (length == 0.0f) length = 1.0f;
		        float ilength = 1.0f/length;

		        q.x = q.x*ilength;
		        q.y = q.y*ilength;
		        q.z = q.z*ilength;
		        q.w = q.w*ilength;
		    }

		    Vector3 resAxis = .(0.0f, 0.0f, 0.0f);
		    float resAngle = 2.0f*Math.Acos(q.w);
		    float den = Math.Sqrt(1.0f - q.w*q.w);

		    if (den > 0.0001f)
		    {
		        resAxis.x = q.x/den;
		        resAxis.y = q.y/den;
		        resAxis.z = q.z/den;
		    }
		    else
		    {
		        // This occurs when the angle is zero.
		        // Not a problem: just set an arbitrary normalized axis.
		        resAxis.x = 1.0f;
		    }

		    outAxis = resAxis;
		    outAngle = resAngle;
		}

		// Get the quaternion equivalent to Euler angles
		// NOTE: Rotation order is ZYX
		public static Quaternion FromEuler(float pitch, float yaw, float roll)
		{
		    Quaternion result = .();

		    float x0 = Math.Cos(pitch*0.5f);
		    float x1 = Math.Sin(pitch*0.5f);
		    float y0 = Math.Cos(yaw*0.5f);
		    float y1 = Math.Sin(yaw*0.5f);
		    float z0 = Math.Cos(roll*0.5f);
		    float z1 = Math.Sin(roll*0.5f);

		    result.x = x1*y0*z0 - x0*y1*z1;
		    result.y = x0*y1*z0 + x1*y0*z1;
		    result.z = x0*y0*z1 - x1*y1*z0;
		    result.w = x0*y0*z0 + x1*y1*z1;

		    return result;
		}

		// Get the Euler angles equivalent to quaternion (roll, pitch, yaw)
		// NOTE: Angles are returned in a Vector3 struct in radians
		public static Vector3 ToEuler(Quaternion q)
		{
		    Vector3 result = .();

		    // Roll (x-axis rotation)
		    float x0 = 2.0f*(q.w*q.x + q.y*q.z);
		    float x1 = 1.0f - 2.0f*(q.x*q.x + q.y*q.y);
		    result.x = Math.Atan2(x0, x1);

		    // Pitch (y-axis rotation)
		    float y0 = 2.0f*(q.w*q.y - q.z*q.x);
		    y0 = y0 > 1.0f ? 1.0f : y0;
		    y0 = y0 < -1.0f ? -1.0f : y0;
		    result.y = Math.Asin(y0);

		    // Yaw (z-axis rotation)
		    float z0 = 2.0f*(q.w*q.z + q.x*q.y);
		    float z1 = 1.0f - 2.0f*(q.y*q.y + q.z*q.z);
		    result.z = Math.Atan2(z0, z1);

		    return result;
		}

		// Transform a quaternion given a transformation matrix
		public static Quaternion Transform(Quaternion q, Matrix mat)
		{
		    Quaternion result = .();

		    result.x = mat.m0*q.x + mat.m4*q.y + mat.m8*q.z + mat.m12*q.w;
		    result.y = mat.m1*q.x + mat.m5*q.y + mat.m9*q.z + mat.m13*q.w;
		    result.z = mat.m2*q.x + mat.m6*q.y + mat.m10*q.z + mat.m14*q.w;
		    result.w = mat.m3*q.x + mat.m7*q.y + mat.m11*q.z + mat.m15*q.w;

		    return result;
		}
	}

	typealias Vector4 = Quaternion;

	[CRepr]
	struct Matrix
	{
		public float m0, m4, m8, m12;
		public float m1, m5, m9, m13;
		public float m2, m6, m10, m14;
		public float m3, m7, m11, m15;

		public this()
		{
			m0 = 0;
			m4 = 0;
			m8 = 0;
			m12 = 0;
			m1 = 0;
			m5 = 0;
			m9 = 0;
			m13 = 0;
			m2 = 0;
			m6 = 0;
			m10 = 0;
			m14 = 0;
			m3 = 0;
			m7 = 0;
			m11 = 0;
			m15 = 0;
		}

		public this(float _m0, float _m4, float _m8, float _m12, float _m1, float _m5,
			float _m9, float _m13, float _m2, float _m6, float _m10, float _m14, float _m3,
			float _m7, float _m11, float _m15)
		{
			m0 = _m0;
			m4 = _m4;
			m8 = _m8;
			m12 = _m12;
			m1 = _m1;
			m5 = _m5;
			m9 = _m9;
			m13 = _m13;
			m2 = _m2;
			m6 = _m6;
			m10 = _m10;
			m14 = _m14;
			m3 = _m3;
			m7 = _m7;
			m11 = _m11;
			m15 = _m15;
		}

		public float this[int index]
		{
			get
			{
				Debug.Assert(index >= 0 && index <= 15);

				switch (index)
				{
				case 0:
					return m0;
				case 1:
					return m1;
				case 2:
					return m2;
				case 3:
					return m3;
				case 4:
					return m4;
				case 5:
					return m5;
				case 6:
					return m6;
				case 7:
					return m7;
				case 8:
					return m8;
				case 9:
					return m9;
				case 10:
					return m10;
				case 11:
					return m11;
				case 12:
					return m12;
				case 13:
					return m13;
				case 14:
					return m14;
				case 15:
					return m15;
				default:
					Debug.Assert(false);
					return 0; // NOTE(pJotoro): We just do this to get rid of the warning.
				}
			}
			set mut
			{
				Debug.Assert(index >= 0 && index <= 15);

				switch (index)
				{
				case 0:
					m0 = value;
				case 1:
					m1 = value;
				case 2:
					m2 = value;
				case 3:
					m3 = value;
				case 4:
					m4 = value;
				case 5:
					m5 = value;
				case 6:
					m6 = value;
				case 7:
					m7 = value;
				case 8:
					m8 = value;
				case 9:
					m9 = value;
				case 10:
					m10 = value;
				case 11:
					m11 = value;
				case 12:
					m12 = value;
				case 13:
					m13 = value;
				case 14:
					m14 = value;
				case 15:
					m15 = value;
				}
			}
		}

		public float this[int index1, int index2]
		{
			get
			{
				switch (index1)
				{
				case 0:
					switch (index2)
					{
					case 0:
						return m0;
					case 1:
						return m1;
					case 2:
						return m2;
					case 3:
						return m3;
					}
				case 1:
					switch (index2)
					{
					case 0:
						return m4;
					case 1:
						return m5;
					case 2:
						return m6;
					case 3:
						return m7;
					}
				case 2:
					switch (index2)
					{
					case 0:
						return m8;
					case 1:
						return m9;
					case 2:
						return m10;
					case 3:
						return m11;
					}
				case 3:
					switch (index2)
					{
					case 0:
						return m12;
					case 1:
						return m13;
					case 2:
						return m14;
					case 3:
						return m15;
					}
				}
				Debug.Assert(false);
				return 0; // NOTE(pJotoro): We just do this to get rid of the error
			}
		}

		// Compute matrix determinant
		public static float Determinant(Matrix mat)
		{
		    float result = 0.0f;

		    // Cache the matrix values (speed optimization)
		    float a00 = mat.m0, a01 = mat.m1, a02 = mat.m2, a03 = mat.m3;
		    float a10 = mat.m4, a11 = mat.m5, a12 = mat.m6, a13 = mat.m7;
		    float a20 = mat.m8, a21 = mat.m9, a22 = mat.m10, a23 = mat.m11;
		    float a30 = mat.m12, a31 = mat.m13, a32 = mat.m14, a33 = mat.m15;

		    result = a30*a21*a12*a03 - a20*a31*a12*a03 - a30*a11*a22*a03 + a10*a31*a22*a03 +
		             a20*a11*a32*a03 - a10*a21*a32*a03 - a30*a21*a02*a13 + a20*a31*a02*a13 +
		             a30*a01*a22*a13 - a00*a31*a22*a13 - a20*a01*a32*a13 + a00*a21*a32*a13 +
		             a30*a11*a02*a23 - a10*a31*a02*a23 - a30*a01*a12*a23 + a00*a31*a12*a23 +
		             a10*a01*a32*a23 - a00*a11*a32*a23 - a20*a11*a02*a33 + a10*a21*a02*a33 +
		             a20*a01*a12*a33 - a00*a21*a12*a33 - a10*a01*a22*a33 + a00*a11*a22*a33;

		    return result;
		}

		// Get the trace of the matrix (sum of the values along the diagonal)
		public static float Trace(Matrix mat)
		{
		    float result = (mat.m0 + mat.m5 + mat.m10 + mat.m15);

		    return result;
		}

		// Transposes provided matrix
		public static Matrix Transpose(Matrix mat)
		{
		    Matrix result = .();

		    result.m0 = mat.m0;
		    result.m1 = mat.m4;
		    result.m2 = mat.m8;
		    result.m3 = mat.m12;
		    result.m4 = mat.m1;
		    result.m5 = mat.m5;
		    result.m6 = mat.m9;
		    result.m7 = mat.m13;
		    result.m8 = mat.m2;
		    result.m9 = mat.m6;
		    result.m10 = mat.m10;
		    result.m11 = mat.m14;
		    result.m12 = mat.m3;
		    result.m13 = mat.m7;
		    result.m14 = mat.m11;
		    result.m15 = mat.m15;

		    return result;
		}

		// Invert provided matrix
		public static Matrix Invert(Matrix mat)
		{
		    Matrix result = .();

		    // Cache the matrix values (speed optimization)
		    float a00 = mat.m0, a01 = mat.m1, a02 = mat.m2, a03 = mat.m3;
		    float a10 = mat.m4, a11 = mat.m5, a12 = mat.m6, a13 = mat.m7;
		    float a20 = mat.m8, a21 = mat.m9, a22 = mat.m10, a23 = mat.m11;
		    float a30 = mat.m12, a31 = mat.m13, a32 = mat.m14, a33 = mat.m15;

		    float b00 = a00*a11 - a01*a10;
		    float b01 = a00*a12 - a02*a10;
		    float b02 = a00*a13 - a03*a10;
		    float b03 = a01*a12 - a02*a11;
		    float b04 = a01*a13 - a03*a11;
		    float b05 = a02*a13 - a03*a12;
		    float b06 = a20*a31 - a21*a30;
		    float b07 = a20*a32 - a22*a30;
		    float b08 = a20*a33 - a23*a30;
		    float b09 = a21*a32 - a22*a31;
		    float b10 = a21*a33 - a23*a31;
		    float b11 = a22*a33 - a23*a32;

		    // Calculate the invert determinant (inlined to avoid double-caching)
		    float invDet = 1.0f/(b00*b11 - b01*b10 + b02*b09 + b03*b08 - b04*b07 + b05*b06);

		    result.m0 = (a11*b11 - a12*b10 + a13*b09)*invDet;
		    result.m1 = (-a01*b11 + a02*b10 - a03*b09)*invDet;
		    result.m2 = (a31*b05 - a32*b04 + a33*b03)*invDet;
		    result.m3 = (-a21*b05 + a22*b04 - a23*b03)*invDet;
		    result.m4 = (-a10*b11 + a12*b08 - a13*b07)*invDet;
		    result.m5 = (a00*b11 - a02*b08 + a03*b07)*invDet;
		    result.m6 = (-a30*b05 + a32*b02 - a33*b01)*invDet;
		    result.m7 = (a20*b05 - a22*b02 + a23*b01)*invDet;
		    result.m8 = (a10*b10 - a11*b08 + a13*b06)*invDet;
		    result.m9 = (-a00*b10 + a01*b08 - a03*b06)*invDet;
		    result.m10 = (a30*b04 - a31*b02 + a33*b00)*invDet;
		    result.m11 = (-a20*b04 + a21*b02 - a23*b00)*invDet;
		    result.m12 = (-a10*b09 + a11*b07 - a12*b06)*invDet;
		    result.m13 = (a00*b09 - a01*b07 + a02*b06)*invDet;
		    result.m14 = (-a30*b03 + a31*b01 - a32*b00)*invDet;
		    result.m15 = (a20*b03 - a21*b01 + a22*b00)*invDet;

		    return result;
		}

		// Normalize provided matrix
		public static Matrix Normalize(Matrix mat)
		{
		    Matrix result = .();

		    // Cache the matrix values (speed optimization)
		    float a00 = mat.m0, a01 = mat.m1, a02 = mat.m2, a03 = mat.m3;
		    float a10 = mat.m4, a11 = mat.m5, a12 = mat.m6, a13 = mat.m7;
		    float a20 = mat.m8, a21 = mat.m9, a22 = mat.m10, a23 = mat.m11;
		    float a30 = mat.m12, a31 = mat.m13, a32 = mat.m14, a33 = mat.m15;

		    // MatrixDeterminant(mat)
		    float det = a30*a21*a12*a03 - a20*a31*a12*a03 - a30*a11*a22*a03 + a10*a31*a22*a03 +
		                a20*a11*a32*a03 - a10*a21*a32*a03 - a30*a21*a02*a13 + a20*a31*a02*a13 +
		                a30*a01*a22*a13 - a00*a31*a22*a13 - a20*a01*a32*a13 + a00*a21*a32*a13 +
		                a30*a11*a02*a23 - a10*a31*a02*a23 - a30*a01*a12*a23 + a00*a31*a12*a23 +
		                a10*a01*a32*a23 - a00*a11*a32*a23 - a20*a11*a02*a33 + a10*a21*a02*a33 +
		                a20*a01*a12*a33 - a00*a21*a12*a33 - a10*a01*a22*a33 + a00*a11*a22*a33;

		    result.m0 = mat.m0/det;
		    result.m1 = mat.m1/det;
		    result.m2 = mat.m2/det;
		    result.m3 = mat.m3/det;
		    result.m4 = mat.m4/det;
		    result.m5 = mat.m5/det;
		    result.m6 = mat.m6/det;
		    result.m7 = mat.m7/det;
		    result.m8 = mat.m8/det;
		    result.m9 = mat.m9/det;
		    result.m10 = mat.m10/det;
		    result.m11 = mat.m11/det;
		    result.m12 = mat.m12/det;
		    result.m13 = mat.m13/det;
		    result.m14 = mat.m14/det;
		    result.m15 = mat.m15/det;

		    return result;
		}

		// Get identity matrix
		public static Matrix Identity
		{
			get
			{
				return .(1.0f, 0.0f, 0.0f, 0.0f,
					0.0f, 1.0f, 0.0f, 0.0f,
					0.0f, 0.0f, 1.0f, 0.0f,
					0.0f, 0.0f, 0.0f, 1.0f);
			}
		}

		// Add two matrices
		public static Matrix operator+(Matrix left, Matrix right)
		{
			Matrix result = .();

			result.m0 = left.m0 + right.m0;
			result.m1 = left.m1 + right.m1;
			result.m2 = left.m2 + right.m2;
			result.m3 = left.m3 + right.m3;
			result.m4 = left.m4 + right.m4;
			result.m5 = left.m5 + right.m5;
			result.m6 = left.m6 + right.m6;
			result.m7 = left.m7 + right.m7;
			result.m8 = left.m8 + right.m8;
			result.m9 = left.m9 + right.m9;
			result.m10 = left.m10 + right.m10;
			result.m11 = left.m11 + right.m11;
			result.m12 = left.m12 + right.m12;
			result.m13 = left.m13 + right.m13;
			result.m14 = left.m14 + right.m14;
			result.m15 = left.m15 + right.m15;

			return result;
		}

		// Add two matrices
		public void operator+=(Matrix m) mut
		{
			m0 += m.m0;
			m1 += m.m1;
			m2 += m.m2;
			m3 += m.m3;
			m4 += m.m4;
			m5 += m.m5;
			m6 += m.m6;
			m7 += m.m7;
			m8 += m.m8;
			m9 += m.m9;
			m10 += m.m10;
			m11 += m.m11;
			m12 += m.m12;
			m13 += m.m13;
			m14 += m.m14;
			m15 += m.m15;
		}

		// Subtract two matrices (left - right)
		public static Matrix operator-(Matrix left, Matrix right)
		{
			Matrix result = .();

			result.m0 = left.m0 - right.m0;
			result.m1 = left.m1 - right.m1;
			result.m2 = left.m2 - right.m2;
			result.m3 = left.m3 - right.m3;
			result.m4 = left.m4 - right.m4;
			result.m5 = left.m5 - right.m5;
			result.m6 = left.m6 - right.m6;
			result.m7 = left.m7 - right.m7;
			result.m8 = left.m8 - right.m8;
			result.m9 = left.m9 - right.m9;
			result.m10 = left.m10 - right.m10;
			result.m11 = left.m11 - right.m11;
			result.m12 = left.m12 - right.m12;
			result.m13 = left.m13 - right.m13;
			result.m14 = left.m14 - right.m14;
			result.m15 = left.m15 - right.m15;

			return result;
		}

		// Subtract two matrices (left - right)
		public void operator-=(Matrix m) mut
		{
			m0 -= m.m0;
			m1 -= m.m1;
			m2 -= m.m2;
			m3 -= m.m3;
			m4 -= m.m4;
			m5 -= m.m5;
			m6 -= m.m6;
			m7 -= m.m7;
			m8 -= m.m8;
			m9 -= m.m9;
			m10 -= m.m10;
			m11 -= m.m11;
			m12 -= m.m12;
			m13 -= m.m13;
			m14 -= m.m14;
			m15 -= m.m15;
		}

		// Get two matrix multiplication
		// NOTE: When multiplying matrices... the order matters!
		public static Matrix operator*(Matrix left, Matrix right)
		{
			Matrix result = .();

			result.m0 = left.m0*right.m0 + left.m1*right.m4 + left.m2*right.m8 + left.m3*right.m12;
			result.m1 = left.m0*right.m1 + left.m1*right.m5 + left.m2*right.m9 + left.m3*right.m13;
			result.m2 = left.m0*right.m2 + left.m1*right.m6 + left.m2*right.m10 + left.m3*right.m14;
			result.m3 = left.m0*right.m3 + left.m1*right.m7 + left.m2*right.m11 + left.m3*right.m15;
			result.m4 = left.m4*right.m0 + left.m5*right.m4 + left.m6*right.m8 + left.m7*right.m12;
			result.m5 = left.m4*right.m1 + left.m5*right.m5 + left.m6*right.m9 + left.m7*right.m13;
			result.m6 = left.m4*right.m2 + left.m5*right.m6 + left.m6*right.m10 + left.m7*right.m14;
			result.m7 = left.m4*right.m3 + left.m5*right.m7 + left.m6*right.m11 + left.m7*right.m15;
			result.m8 = left.m8*right.m0 + left.m9*right.m4 + left.m10*right.m8 + left.m11*right.m12;
			result.m9 = left.m8*right.m1 + left.m9*right.m5 + left.m10*right.m9 + left.m11*right.m13;
			result.m10 = left.m8*right.m2 + left.m9*right.m6 + left.m10*right.m10 + left.m11*right.m14;
			result.m11 = left.m8*right.m3 + left.m9*right.m7 + left.m10*right.m11 + left.m11*right.m15;
			result.m12 = left.m12*right.m0 + left.m13*right.m4 + left.m14*right.m8 + left.m15*right.m12;
			result.m13 = left.m12*right.m1 + left.m13*right.m5 + left.m14*right.m9 + left.m15*right.m13;
			result.m14 = left.m12*right.m2 + left.m13*right.m6 + left.m14*right.m10 + left.m15*right.m14;
			result.m15 = left.m12*right.m3 + left.m13*right.m7 + left.m14*right.m11 + left.m15*right.m15;

			return result;
		}

		// Get two matrix multiplication
		// NOTE: When multiplying matrices... the order matters!
		public void operator*=(Matrix m) mut
		{
			Matrix result = this;

			result.m0 = m0*m.m0 + m1*m.m4 + m2*m.m8 + m3*m.m12;
			result.m1 = m0*m.m1 + m1*m.m5 + m2*m.m9 + m3*m.m13;
			result.m2 = m0*m.m2 + m1*m.m6 + m2*m.m10 + m3*m.m14;
			result.m3 = m0*m.m3 + m1*m.m7 + m2*m.m11 + m3*m.m15;
			result.m4 = m4*m.m0 + m5*m.m4 + m6*m.m8 + m7*m.m12;
			result.m5 = m4*m.m1 + m5*m.m5 + m6*m.m9 + m7*m.m13;
			result.m6 = m4*m.m2 + m5*m.m6 + m6*m.m10 + m7*m.m14;
			result.m7 = m4*m.m3 + m5*m.m7 + m6*m.m11 + m7*m.m15;
			result.m8 = m8*m.m0 + m9*m.m4 + m10*m.m8 + m11*m.m12;
			result.m9 = m8*m.m1 + m9*m.m5 + m10*m.m9 + m11*m.m13;
			result.m10 = m8*m.m2 + m9*m.m6 + m10*m.m10 + m11*m.m14;
			result.m11 = m8*m.m3 + m9*m.m7 + m10*m.m11 + m11*m.m15;
			result.m12 = m12*m.m0 + m13*m.m4 + m14*m.m8 + m15*m.m12;
			result.m13 = m12*m.m1 + m13*m.m5 + m14*m.m9 + m15*m.m13;
			result.m14 = m12*m.m2 + m13*m.m6 + m14*m.m10 + m15*m.m14;
			result.m15 = m12*m.m3 + m13*m.m7 + m14*m.m11 + m15*m.m15;

			this = result;
		}

		// Get translation matrix
		public static Matrix Translate(float x, float y, float z)
		{
			Matrix result = .(1.0f, 0.0f, 0.0f, x,
			                  0.0f, 1.0f, 0.0f, y,
			                  0.0f, 0.0f, 1.0f, z,
			                  0.0f, 0.0f, 0.0f, 1.0f);

			return result;
		}

		// Create rotation matrix from axis and angle
		// NOTE: Angle should be provided in radians
		public static Matrix Rotate(Vector3 axis, float angle)
		{
		    Matrix result = .();

		    float x = axis.x, y = axis.y, z = axis.z;

		    float lengthSquared = x*x + y*y + z*z;

		    if ((lengthSquared != 1.0f) && (lengthSquared != 0.0f))
		    {
		        float ilength = 1.0f/Math.Sqrt(lengthSquared);
		        x *= ilength;
		        y *= ilength;
		        z *= ilength;
		    }

		    float sinres = Math.Sin(angle);
		    float cosres = Math.Cos(angle);
		    float t = 1.0f - cosres;

		    result.m0 = x*x*t + cosres;
		    result.m1 = y*x*t + z*sinres;
		    result.m2 = z*x*t - y*sinres;
		    result.m3 = 0.0f;

		    result.m4 = x*y*t - z*sinres;
		    result.m5 = y*y*t + cosres;
		    result.m6 = z*y*t + x*sinres;
		    result.m7 = 0.0f;

		    result.m8 = x*z*t + y*sinres;
		    result.m9 = y*z*t - x*sinres;
		    result.m10 = z*z*t + cosres;
		    result.m11 = 0.0f;

		    result.m12 = 0.0f;
		    result.m13 = 0.0f;
		    result.m14 = 0.0f;
		    result.m15 = 1.0f;

		    return result;
		}

		// Get x-rotation matrix (angle in radians)
		public static Matrix RotateX(float angle)
		{
		    Matrix result = .(1.0f, 0.0f, 0.0f, 0.0f,
		                      0.0f, 1.0f, 0.0f, 0.0f,
		                      0.0f, 0.0f, 1.0f, 0.0f,
		                      0.0f, 0.0f, 0.0f, 1.0f); // MatrixIdentity()

		    float cosres = Math.Cos(angle);
		    float sinres = Math.Sin(angle);

		    result.m5 = cosres;
		    result.m6 = -sinres;
		    result.m9 = sinres;
		    result.m10 = cosres;

		    return result;
		}

		// Get y-rotation matrix (angle in radians)
		public static Matrix RotateY(float angle)
		{
		    Matrix result = .(1.0f, 0.0f, 0.0f, 0.0f,
		                      0.0f, 1.0f, 0.0f, 0.0f,
		                      0.0f, 0.0f, 1.0f, 0.0f,
		                      0.0f, 0.0f, 0.0f, 1.0f); // MatrixIdentity()

		    float cosres = Math.Cos(angle);
		    float sinres = Math.Sin(angle);

		    result.m0 = cosres;
		    result.m2 = sinres;
		    result.m8 = -sinres;
		    result.m10 = cosres;

		    return result;
		}

		// Get z-rotation matrix (angle in radians)
		public static Matrix RotateZ(float angle)
		{
		    Matrix result = .(1.0f, 0.0f, 0.0f, 0.0f,
		                      0.0f, 1.0f, 0.0f, 0.0f,
		                      0.0f, 0.0f, 1.0f, 0.0f,
		                      0.0f, 0.0f, 0.0f, 1.0f); // MatrixIdentity()

		    float cosres = Math.Cos(angle);
		    float sinres = Math.Sin(angle);

		    result.m0 = cosres;
		    result.m1 = -sinres;
		    result.m4 = sinres;
		    result.m5 = cosres;

		    return result;
		}

		// Get xyz-rotation matrix (angles in radians)
		public static Matrix RotateXYZ(Vector3 ang)
		{
		    Matrix result = .(1.0f, 0.0f, 0.0f, 0.0f,
		                      0.0f, 1.0f, 0.0f, 0.0f,
		                      0.0f, 0.0f, 1.0f, 0.0f,
		                      0.0f, 0.0f, 0.0f, 1.0f); // MatrixIdentity()

		    float cosz = Math.Cos(-ang.z);
		    float sinz = Math.Sin(-ang.z);
		    float cosy = Math.Cos(-ang.y);
		    float siny = Math.Sin(-ang.y);
		    float cosx = Math.Cos(-ang.x);
		    float sinx = Math.Sin(-ang.x);

		    result.m0 = cosz*cosy;
		    result.m4 = (cosz*siny*sinx) - (sinz*cosx);
		    result.m8 = (cosz*siny*cosx) + (sinz*sinx);

		    result.m1 = sinz*cosy;
		    result.m5 = (sinz*siny*sinx) + (cosz*cosx);
		    result.m9 = (sinz*siny*cosx) - (cosz*sinx);

		    result.m2 = -siny;
		    result.m6 = cosy*sinx;
		    result.m10= cosy*cosx;

		    return result;
		}

		// Get zyx-rotation matrix (angles in radians)
		public static Matrix RotateZYX(Vector3 ang)
		{
		    Matrix result = .();

		    float cz = Math.Cos(ang.z);
		    float sz = Math.Sin(ang.z);
		    float cy = Math.Cos(ang.y);
		    float sy = Math.Sin(ang.y);
		    float cx = Math.Cos(ang.x);
		    float sx = Math.Sin(ang.x);

		    result.m0 = cz*cy;
		    result.m1 = cz*sy*sx - cx*sz;
		    result.m2 = sz*sx + cz*cx*sy;
		    result.m3 = 0;

		    result.m4 = cy*sz;
		    result.m5 = cz*cx + sz*sy*sx;
		    result.m6 = cx*sz*sy - cz*sx;
		    result.m7 = 0;

		    result.m8 = -sy;
		    result.m9 = cy*sx;
		    result.m10 = cy*cx;
		    result.m11 = 0;

		    result.m12 = 0;
		    result.m13 = 0;
		    result.m14 = 0;
		    result.m15 = 1;

		    return result;
		}

		// Get scaling matrix
		public static Matrix Scale(float x, float y, float z)
		{
		    Matrix result = .(x, 0.0f, 0.0f, 0.0f,
		                      0.0f, y, 0.0f, 0.0f,
		                      0.0f, 0.0f, z, 0.0f,
		                      0.0f, 0.0f, 0.0f, 1.0f);

		    return result;
		}

		// Get perspective projection matrix
		public static Matrix Frustum(double left, double right, double bottom, double top, double near, double far)
		{
		    Matrix result = .();

		    float rl = (float)(right - left);
		    float tb = (float)(top - bottom);
		    float fn = (float)(far - near);

		    result.m0 = ((float)near*2.0f)/rl;
		    result.m1 = 0.0f;
		    result.m2 = 0.0f;
		    result.m3 = 0.0f;

		    result.m4 = 0.0f;
		    result.m5 = ((float)near*2.0f)/tb;
		    result.m6 = 0.0f;
		    result.m7 = 0.0f;

		    result.m8 = ((float)right + (float)left)/rl;
		    result.m9 = ((float)top + (float)bottom)/tb;
		    result.m10 = -((float)far + (float)near)/fn;
		    result.m11 = -1.0f;

		    result.m12 = 0.0f;
		    result.m13 = 0.0f;
		    result.m14 = -((float)far*(float)near*2.0f)/fn;
		    result.m15 = 0.0f;

		    return result;
		}

		// Get perspective projection matrix
		// NOTE: Angle should be provided in radians
		public static Matrix Perspective(double fovy, double aspect, double near, double far)
		{
		    Matrix result = .();

		    double top = near*Math.Tan(fovy*0.5);
		    double bottom = -top;
		    double right = top*aspect;
		    double left = -right;

		    // MatrixFrustum(-right, right, -top, top, near, far);
		    float rl = (float)(right - left);
		    float tb = (float)(top - bottom);
		    float fn = (float)(far - near);

		    result.m0 = ((float)near*2.0f)/rl;
		    result.m5 = ((float)near*2.0f)/tb;
		    result.m8 = ((float)right + (float)left)/rl;
		    result.m9 = ((float)top + (float)bottom)/tb;
		    result.m10 = -((float)far + (float)near)/fn;
		    result.m11 = -1.0f;
		    result.m14 = -((float)far*(float)near*2.0f)/fn;

		    return result;
		}

		// Get orthographic projection matrix
		public static Matrix Ortho(double left, double right, double bottom, double top, double near, double far)
		{
		    Matrix result = .();

		    float rl = (float)(right - left);
		    float tb = (float)(top - bottom);
		    float fn = (float)(far - near);

		    result.m0 = 2.0f/rl;
		    result.m1 = 0.0f;
		    result.m2 = 0.0f;
		    result.m3 = 0.0f;
		    result.m4 = 0.0f;
		    result.m5 = 2.0f/tb;
		    result.m6 = 0.0f;
		    result.m7 = 0.0f;
		    result.m8 = 0.0f;
		    result.m9 = 0.0f;
		    result.m10 = -2.0f/fn;
		    result.m11 = 0.0f;
		    result.m12 = -((float)left + (float)right)/rl;
		    result.m13 = -((float)top + (float)bottom)/tb;
		    result.m14 = -((float)far + (float)near)/fn;
		    result.m15 = 1.0f;

		    return result;
		}

		// Get camera look-at matrix (view matrix)
		public static Matrix LookAt(Vector3 eye, Vector3 target, Vector3 up)
		{
		    Matrix result = .();

		    float length = 0.0f;
		    float ilength = 0.0f;

		    // Vector3Subtract(eye, target)
		    Vector3 vz = .(eye.x - target.x, eye.y - target.y, eye.z - target.z);

		    // Vector3Normalize(vz)
		    Vector3 v = vz;
		    length = Math.Sqrt(v.x*v.x + v.y*v.y + v.z*v.z);
		    if (length == 0.0f) length = 1.0f;
		    ilength = 1.0f/length;
		    vz.x *= ilength;
		    vz.y *= ilength;
		    vz.z *= ilength;

		    // Vector3CrossProduct(up, vz)
		    Vector3 vx = .(up.y*vz.z - up.z*vz.y, up.z*vz.x - up.x*vz.z, up.x*vz.y - up.y*vz.x);

		    // Vector3Normalize(x)
		    v = vx;
		    length = Math.Sqrt(v.x*v.x + v.y*v.y + v.z*v.z);
		    if (length == 0.0f) length = 1.0f;
		    ilength = 1.0f/length;
		    vx.x *= ilength;
		    vx.y *= ilength;
		    vx.z *= ilength;

		    // Vector3CrossProduct(vz, vx)
		    Vector3 vy = .(vz.y*vx.z - vz.z*vx.y, vz.z*vx.x - vz.x*vx.z, vz.x*vx.y - vz.y*vx.x);

		    result.m0 = vx.x;
		    result.m1 = vy.x;
		    result.m2 = vz.x;
		    result.m3 = 0.0f;
		    result.m4 = vx.y;
		    result.m5 = vy.y;
		    result.m6 = vz.y;
		    result.m7 = 0.0f;
		    result.m8 = vx.z;
		    result.m9 = vy.z;
		    result.m10 = vz.z;
		    result.m11 = 0.0f;
		    result.m12 = -(vx.x*eye.x + vx.y*eye.y + vx.z*eye.z);   // Vector3DotProduct(vx, eye)
		    result.m13 = -(vy.x*eye.x + vy.y*eye.y + vy.z*eye.z);   // Vector3DotProduct(vy, eye)
		    result.m14 = -(vz.x*eye.x + vz.y*eye.y + vz.z*eye.z);   // Vector3DotProduct(vz, eye)
		    result.m15 = 1.0f;

		    return result;
		}

		// Get float array of matrix data
		public static float16 ToFloatV(Matrix mat)
		{
		    float16 result = .();

		    result.v[0] = mat.m0;
		    result.v[1] = mat.m1;
		    result.v[2] = mat.m2;
		    result.v[3] = mat.m3;
		    result.v[4] = mat.m4;
		    result.v[5] = mat.m5;
		    result.v[6] = mat.m6;
		    result.v[7] = mat.m7;
		    result.v[8] = mat.m8;
		    result.v[9] = mat.m9;
		    result.v[10] = mat.m10;
		    result.v[11] = mat.m11;
		    result.v[12] = mat.m12;
		    result.v[13] = mat.m13;
		    result.v[14] = mat.m14;
		    result.v[15] = mat.m15;

		    return result;
		}
	}

	[CRepr]
	struct Color
	{
		public uint8 r;
		public uint8 g;
		public uint8 b;
		public uint8 a;

		public this()
		{
			r = 0;
			g = 0;
			b = 0;
			a = 0;
		}

		public this(uint8 _r, uint8 _g, uint8 _b, uint8 _a)
		{
			r = _r;
			g = _g;
			b = _b;
			a = _a;
		}
	}

	[CRepr]
	struct Rectangle
	{
		public float x;
		public float y;
		public float width;
		public float height;
	}

	[CRepr]
	struct Image
	{
		public void* data;
		public int32 width;
		public int32 height;
		public int32 mipmaps;
		public int32 format;
	}

	[CRepr]
	struct Texture
	{
		public uint32 id;
		public int32 width;
		public int32 height;
		public int32 mipmaps;
		public int32 format;
	}

	typealias Texture2D = Texture;
	typealias TextureCubemap = Texture;

	[CRepr]
	struct RenderTexture
	{
		public uint32 id;
		public Texture texture;
		public Texture depth;
	}

	typealias RenderTexture2D = RenderTexture;

	[CRepr]
	struct NPatchInfo
	{
		public Rectangle source;
		public int32 left;
		public int32 top;
		public int32 right;
		public int32 bottom;
		public int32 layout;
	}

	[CRepr]
	struct GlyphInfo
	{
		public int32 value;
		public int32 offsetX;
		public int32 offsetY;
		public int32 advanceX;
		public Image image;
	}

	[CRepr]
	struct Font
	{
		public int32 baseSize;
		public int32 glyphCount;
		public int32 glyphPadding;
		public Texture2D texture;
		public Rectangle* recs;
		public GlyphInfo* glyphs;
	}

	[CRepr]
	struct Camera3D
	{
		public Vector3 position;
		public Vector3 target;
		public Vector3 up;
		public float fovy;
		public int32 projection;
	}

	typealias Camera = Camera3D;

	[CRepr]
	struct Camera2D
	{
		public Vector2 offset;
		public Vector2 target;
		public float rotation;
		public float zoom;
	}

	[CRepr]
	struct Mesh
	{
		public int32 vertexCount;
		public int32 triangleCount;

		public float* vertices;
		public float* texcoords;
		public float* texcoords2;
		public float* normals;
		public float* tangents;
		public uint8* colors;
		public uint16* indices;

		public float* animVertices;
		public float* animNormals;
		public uint8* boneIds;
		public float* boneWeights;

		public uint32 vaoId;
		public uint32 *vboId;
	}

	[CRepr]
	struct Shader
	{
		public uint32 id;
		public int32* locs;
	}

	[CRepr]
	struct MaterialMap
	{
		public Texture2D texture;
		public Color color;
		public float value;
	}

	[CRepr]
	struct Material
	{
		public Shader shader;
		public MaterialMap* maps;
		public float[4] params_;
	}

	[CRepr]
	struct Transform
	{
		public Vector3 translation;
		public Quaternion rotation;
		public Vector3 scale;
	}

	[CRepr]
	struct BoneInfo
	{
		public char8[32] name;
		public int32 parent;
	}

	[CRepr]
	struct Model
	{
		public Matrix transform;

		public int32 meshCount;
		public int32 materialCount;
		public Mesh* meshes;
		public Material* materials;
		public int32* meshMaterial;

		public int32 boneCount;
		public BoneInfo* bones;
		public Transform* bindPose;
	}

	[CRepr]
	struct ModelAnimation
	{
		public int32 boneCount;
		public int32 frameCount;
		public BoneInfo* bones;
		public Transform** framePoses;
	}

	[CRepr]
	struct Ray
	{
		public Vector3 position;
		public Vector3 direction;
	}

	[CRepr]
	struct RayCollision
	{
		public bool hit;
		public float distance;
		public Vector3 point;
		public Vector3 normal;
	}

	[CRepr]
	struct BoundingBox
	{
		public Vector3 min;
		public Vector3 max;
	}

	[CRepr]
	struct Wave
	{
		public uint32 frameCount;
		public uint32 sampleRate;
		public uint32 sampleSize;
		public uint32 channels;
		public void* data;
	}

	[CRepr]
	struct AudioStream
	{
		public void* buffer;

		public uint32 sampleRate;
		public uint32 sampleSize;
		public uint32 channels;
	}

	[CRepr]
	struct Sound
	{
		public AudioStream stream;
		public uint32 frameCount;
	}

	[CRepr]
	struct Music
	{
		public AudioStream stream;
		public uint32 frameCount;
		public bool looping;

		public int32 ctxType;
		public void* ctxData;
	}

	[CRepr]
	struct VrDeviceInfo
	{
		public int32 hResolution;              // Horizontal resolution in pixels
		public int32 vResolution;              // Vertical resolution in pixels
		public float hScreenSize;              // Horizontal size in meters
		public float vScreenSize;              // Vertical size in meters
		public float vScreenCenter;            // Screen center in meters
		public float eyeToScreenDistance;      // Distance between eye and display in meters
		public float lensSeparationDistance;   // Lens separation distance in meters
		public float interpupillaryDistance;   // IPD (distance between pupils) in meters
		public float[4] lensDistortionValues;  // Lens distortion constant parameters
		public float[4] chromaAbCorrection;    // Chromatic aberration correction parameters
	}

	[CRepr]
	struct VrStereoConfig
	{
		Matrix[2] projection;           // VR projection matrices (per eye)
		Matrix[2] viewOffset;           // VR view offset matrices (per eye)
		float[2] leftLensCenter;        // VR left lens center
		float[2] rightLensCenter;       // VR right lens center
		float[2] leftScreenCenter;      // VR left screen center
		float[2] rightScreenCenter;     // VR right screen center
		float[2] scale;                 // VR distortion scale
		float[2] scaleIn;               // VR distortion scale in
	}

	enum ConfigFlags : int32
	{
		VSYNC_HINT         = 0x00000040,   // Set to try enabling V-Sync on GPU
		FULLSCREEN_MODE    = 0x00000002,   // Set to run program in fullscreen
		WINDOW_RESIZABLE   = 0x00000004,   // Set to allow resizable window
		WINDOW_UNDECORATED = 0x00000008,   // Set to disable window decoration (frame and buttons)
		WINDOW_HIDDEN      = 0x00000080,   // Set to hide window
		WINDOW_MINIMIZED   = 0x00000200,   // Set to minimize window (iconify)
		WINDOW_MAXIMIZED   = 0x00000400,   // Set to maximize window (expanded to monitor)
		WINDOW_UNFOCUSED   = 0x00000800,   // Set to window non focused
		WINDOW_TOPMOST     = 0x00001000,   // Set to window always on top
		WINDOW_ALWAYS_RUN  = 0x00000100,   // Set to allow windows running while minimized
		WINDOW_TRANSPARENT = 0x00000010,   // Set to allow transparent framebuffer
		WINDOW_HIGHDPI     = 0x00002000,   // Set to support HighDPI
		MSAA_4X_HINT       = 0x00000020,   // Set to try enabling MSAA 4X
		INTERLACED_HINT    = 0x00010000    // Set to try enabling interlaced video format (for V3D)
	}

	enum TraceLogLevel : int32
	{
		ALL = 0,        // Display all logs
		TRACE,          // Trace logging, intended for internal use only
		DEBUG,          // Debug logging, used for internal debugging, it should be disabled on release builds
		INFO,           // Info logging, used for program execution info
		WARNING,        // Warning logging, used on recoverable failures
		ERROR,          // Error logging, used on unrecoverable failures
		FATAL,          // Fatal logging, used to abort program: exit(EXIT_FAILURE)
		NONE            // Disable logging
	}

	[AllowDuplicates]
	enum KeyboardKey : int32
	{
		NULL            = 0,        // Key: NULL, used for no key pressed
		// Alphanumeric keys
		APOSTROPHE      = 39,       // Key: '
		COMMA           = 44,       // Key: ,
		MINUS           = 45,       // Key: -
		PERIOD          = 46,       // Key: .
		SLASH           = 47,       // Key: /
		ZERO            = 48,       // Key: 0
		ONE             = 49,       // Key: 1
		TWO             = 50,       // Key: 2
		THREE           = 51,       // Key: 3
		FOUR            = 52,       // Key: 4
		FIVE            = 53,       // Key: 5
		SIX             = 54,       // Key: 6
		SEVEN           = 55,       // Key: 7
		EIGHT           = 56,       // Key: 8
		NINE            = 57,       // Key: 9
		SEMICOLON       = 59,       // Key: ;
		EQUAL           = 61,       // Key: =
		A               = 65,       // Key: A | a
		B               = 66,       // Key: B | b
		C               = 67,       // Key: C | c
		D               = 68,       // Key: D | d
		E               = 69,       // Key: E | e
		F               = 70,       // Key: F | f
		G               = 71,       // Key: G | g
		H               = 72,       // Key: H | h
		I               = 73,       // Key: I | i
		J               = 74,       // Key: J | j
		K               = 75,       // Key: K | k
		L               = 76,       // Key: L | l
		M               = 77,       // Key: M | m
		N               = 78,       // Key: N | n
		O               = 79,       // Key: O | o
		P               = 80,       // Key: P | p
		Q               = 81,       // Key: Q | q
		R               = 82,       // Key: R | r
		S               = 83,       // Key: S | s
		T               = 84,       // Key: T | t
		U               = 85,       // Key: U | u
		V               = 86,       // Key: V | v
		W               = 87,       // Key: W | w
		X               = 88,       // Key: X | x
		Y               = 89,       // Key: Y | y
		Z               = 90,       // Key: Z | z
		LEFT_BRACKET    = 91,       // Key: [
		BACKSLASH       = 92,       // Key: '\'
		RIGHT_BRACKET   = 93,       // Key: ]
		GRAVE           = 96,       // Key: `
		// Function keys
		SPACE           = 32,       // Key: Space
		ESCAPE          = 256,      // Key: Esc
		ENTER           = 257,      // Key: Enter
		TAB             = 258,      // Key: Tab
		BACKSPACE       = 259,      // Key: Backspace
		INSERT          = 260,      // Key: Ins
		DELETE          = 261,      // Key: Del
		RIGHT           = 262,      // Key: Cursor right
		LEFT            = 263,      // Key: Cursor left
		DOWN            = 264,      // Key: Cursor down
		UP              = 265,      // Key: Cursor up
		PAGE_UP         = 266,      // Key: Page up
		PAGE_DOWN       = 267,      // Key: Page down
		HOME            = 268,      // Key: Home
		END             = 269,      // Key: End
		CAPS_LOCK       = 280,      // Key: Caps lock
		SCROLL_LOCK     = 281,      // Key: Scroll down
		NUM_LOCK        = 282,      // Key: Num lock
		PRINT_SCREEN    = 283,      // Key: Print screen
		PAUSE           = 284,      // Key: Pause
		F1              = 290,      // Key: F1
		F2              = 291,      // Key: F2
		F3              = 292,      // Key: F3
		F4              = 293,      // Key: F4
		F5              = 294,      // Key: F5
		F6              = 295,      // Key: F6
		F7              = 296,      // Key: F7
		F8              = 297,      // Key: F8
		F9              = 298,      // Key: F9
		F10             = 299,      // Key: F10
		F11             = 300,      // Key: F11
		F12             = 301,      // Key: F12
		LEFT_SHIFT      = 340,      // Key: Shift left
		LEFT_CONTROL    = 341,      // Key: Control left
		LEFT_ALT        = 342,      // Key: Alt left
		LEFT_SUPER      = 343,      // Key: Super left
		RIGHT_SHIFT     = 344,      // Key: Shift right
		RIGHT_CONTROL   = 345,      // Key: Control right
		RIGHT_ALT       = 346,      // Key: Alt right
		RIGHT_SUPER     = 347,      // Key: Super right
		KB_MENU         = 348,      // Key: KB menu
		// Keypad keys
		KP_0            = 320,      // Key: Keypad 0
		KP_1            = 321,      // Key: Keypad 1
		KP_2            = 322,      // Key: Keypad 2
		KP_3            = 323,      // Key: Keypad 3
		KP_4            = 324,      // Key: Keypad 4
		KP_5            = 325,      // Key: Keypad 5
		KP_6            = 326,      // Key: Keypad 6
		KP_7            = 327,      // Key: Keypad 7
		KP_8            = 328,      // Key: Keypad 8
		KP_9            = 329,      // Key: Keypad 9
		KP_DECIMAL      = 330,      // Key: Keypad .
		KP_DIVIDE       = 331,      // Key: Keypad /
		KP_MULTIPLY     = 332,      // Key: Keypad *
		KP_SUBTRACT     = 333,      // Key: Keypad -
		KP_ADD          = 334,      // Key: Keypad +
		KP_ENTER        = 335,      // Key: Keypad Enter
		KP_EQUAL        = 336,      // Key: Keypad =
		// Android key buttons
		BACK            = 4,        // Key: Android back button
		MENU            = 82,       // Key: Android menu button
		VOLUME_UP       = 24,       // Key: Android volume up button
		VOLUME_DOWN     = 25        // Key: Android volume down button
	}

	enum MouseButton : int32
	{
		LEFT    = 0,       // Mouse button left
		RIGHT   = 1,       // Mouse button right
		MIDDLE  = 2,       // Mouse button middle (pressed wheel)
		SIDE    = 3,       // Mouse button side (advanced mouse device)
		EXTRA   = 4,       // Mouse button extra (advanced mouse device)
		FORWARD = 5,       // Mouse button fordward (advanced mouse device)
		BACK    = 6,       // Mouse button back (advanced mouse device)
	}

	enum MouseCursor : int32
	{
		DEFAULT       = 0,     // Default pointer shape
		ARROW         = 1,     // Arrow shape
		IBEAM         = 2,     // Text writing cursor shape
		CROSSHAIR     = 3,     // Cross shape
		POINTING_HAND = 4,     // Pointing hand cursor
		RESIZE_EW     = 5,     // Horizontal resize/move arrow shape
		RESIZE_NS     = 6,     // Vertical resize/move arrow shape
		RESIZE_NWSE   = 7,     // Top-left to bottom-right diagonal resize/move arrow shape
		RESIZE_NESW   = 8,     // The top-right to bottom-left diagonal resize/move arrow shape
		RESIZE_ALL    = 9,     // The omni-directional resize/move cursor shape
		NOT_ALLOWED   = 10     // The operation-not-allowed shape
	}

	enum GamepadButton : int32
	{
		UNKNOWN = 0,         // Unknown button, just for error checking
		LEFT_FACE_UP,        // Gamepad left DPAD up button
		LEFT_FACE_RIGHT,     // Gamepad left DPAD right button
		LEFT_FACE_DOWN,      // Gamepad left DPAD down button
		LEFT_FACE_LEFT,      // Gamepad left DPAD left button
		RIGHT_FACE_UP,       // Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
		RIGHT_FACE_RIGHT,    // Gamepad right button right (i.e. PS3: Square, Xbox: X)
		RIGHT_FACE_DOWN,     // Gamepad right button down (i.e. PS3: Cross, Xbox: A)
		RIGHT_FACE_LEFT,     // Gamepad right button left (i.e. PS3: Circle, Xbox: B)
		LEFT_TRIGGER_1,      // Gamepad top/back trigger left (first), it could be a trailing button
		LEFT_TRIGGER_2,      // Gamepad top/back trigger left (second), it could be a trailing button
		RIGHT_TRIGGER_1,     // Gamepad top/back trigger right (one), it could be a trailing button
		RIGHT_TRIGGER_2,     // Gamepad top/back trigger right (second), it could be a trailing button
		MIDDLE_LEFT,         // Gamepad center buttons, left one (i.e. PS3: Select)
		MIDDLE,              // Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
		MIDDLE_RIGHT,        // Gamepad center buttons, right one (i.e. PS3: Start)
		LEFT_THUMB,          // Gamepad joystick pressed button left
		RIGHT_THUMB          // Gamepad joystick pressed button right
	}

	enum GamepadAxis : int32
	{
		LEFT_X        = 0,     // Gamepad left stick X axis
		LEFT_Y        = 1,     // Gamepad left stick Y axis
		RIGHT_X       = 2,     // Gamepad right stick X axis
		RIGHT_Y       = 3,     // Gamepad right stick Y axis
		LEFT_TRIGGER  = 4,     // Gamepad back trigger left, pressure level: [1..-1]
		RIGHT_TRIGGER = 5      // Gamepad back trigger right, pressure level: [1..-1]
	}

	enum MaterialMapIndex : int32
	{
		ALBEDO    = 0,     // Albedo material (same as: DIFFUSE)
		METALNESS,         // Metalness material (same as: SPECULAR)
		NORMAL,            // Normal material
		ROUGHNESS,         // Roughness material
		OCCLUSION,         // Ambient occlusion material
		EMISSION,          // Emission material
		HEIGHT,            // Heightmap material
		CUBEMAP,           // Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
		IRRADIANCE,        // Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
		PREFILTER,         // Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
		BRDF               // Brdf material
	}

	enum ShaderLocationIndex : int32
	{
		VERTEX_POSITION = 0, // Shader location: vertex attribute: position
		VERTEX_TEXCOORD01,   // Shader location: vertex attribute: texcoord01
		VERTEX_TEXCOORD02,   // Shader location: vertex attribute: texcoord02
		VERTEX_NORMAL,       // Shader location: vertex attribute: normal
		VERTEX_TANGENT,      // Shader location: vertex attribute: tangent
		VERTEX_COLOR,        // Shader location: vertex attribute: color
		MATRIX_MVP,          // Shader location: matrix uniform: model-view-projection
		MATRIX_VIEW,         // Shader location: matrix uniform: view (camera transform)
		MATRIX_PROJECTION,   // Shader location: matrix uniform: projection
		MATRIX_MODEL,        // Shader location: matrix uniform: model (transform)
		MATRIX_NORMAL,       // Shader location: matrix uniform: normal
		VECTOR_VIEW,         // Shader location: vector uniform: view
		COLOR_DIFFUSE,       // Shader location: vector uniform: diffuse color
		COLOR_SPECULAR,      // Shader location: vector uniform: specular color
		COLOR_AMBIENT,       // Shader location: vector uniform: ambient color
		MAP_ALBEDO,          // Shader location: sampler2d texture: albedo (same as: MAP_DIFFUSE)
		MAP_METALNESS,       // Shader location: sampler2d texture: metalness (same as: MAP_SPECULAR)
		MAP_NORMAL,          // Shader location: sampler2d texture: normal
		MAP_ROUGHNESS,       // Shader location: sampler2d texture: roughness
		MAP_OCCLUSION,       // Shader location: sampler2d texture: occlusion
		MAP_EMISSION,        // Shader location: sampler2d texture: emission
		MAP_HEIGHT,          // Shader location: sampler2d texture: height
		MAP_CUBEMAP,         // Shader location: samplerCube texture: cubemap
		MAP_IRRADIANCE,      // Shader location: samplerCube texture: irradiance
		MAP_PREFILTER,       // Shader location: samplerCube texture: prefilter
		MAP_BRDF             // Shader location: sampler2d texture: brdf
	}

	enum ShaderUniformDataType : int32
	{
		FLOAT = 0,       // Shader uniform type: float
		VEC2,            // Shader uniform type: vec2 (2 float)
		VEC3,            // Shader uniform type: vec3 (3 float)
		VEC4,            // Shader uniform type: vec4 (4 float)
		INT,             // Shader uniform type: int
		IVEC2,           // Shader uniform type: ivec2 (2 int)
		IVEC3,           // Shader uniform type: ivec3 (3 int)
		IVEC4,           // Shader uniform type: ivec4 (4 int)
		SAMPLER2D        // Shader uniform type: sampler2d
	}

	enum ShaderAttributeDataType : int32
	{
		FLOAT = 0,        // Shader attribute type: float
		VEC2,             // Shader attribute type: vec2 (2 float)
		VEC3,             // Shader attribute type: vec3 (3 float)
		VEC4              // Shader attribute type: vec4 (4 float)
	}

	enum PixelFormat : int32
	{
		UNCOMPRESSED_GRAYSCALE = 1, // 8 bit per pixel (no alpha)
		UNCOMPRESSED_GRAY_ALPHA,    // 8*2 bpp (2 channels)
		UNCOMPRESSED_R5G6B5,        // 16 bpp
		UNCOMPRESSED_R8G8B8,        // 24 bpp
		UNCOMPRESSED_R5G5B5A1,      // 16 bpp (1 bit alpha)
		UNCOMPRESSED_R4G4B4A4,      // 16 bpp (4 bit alpha)
		UNCOMPRESSED_R8G8B8A8,      // 32 bpp
		UNCOMPRESSED_R32,           // 32 bpp (1 channel - float)
		UNCOMPRESSED_R32G32B32,     // 32*3 bpp (3 channels - float)
		UNCOMPRESSED_R32G32B32A32,  // 32*4 bpp (4 channels - float)
		COMPRESSED_DXT1_RGB,        // 4 bpp (no alpha)
		COMPRESSED_DXT1_RGBA,       // 4 bpp (1 bit alpha)
		COMPRESSED_DXT3_RGBA,       // 8 bpp
		COMPRESSED_DXT5_RGBA,       // 8 bpp
		COMPRESSED_ETC1_RGB,        // 4 bpp
		COMPRESSED_ETC2_RGB,        // 4 bpp
		COMPRESSED_ETC2_EAC_RGBA,   // 8 bpp
		COMPRESSED_PVRT_RGB,        // 4 bpp
		COMPRESSED_PVRT_RGBA,       // 4 bpp
		COMPRESSED_ASTC_4x4_RGBA,   // 8 bpp
		COMPRESSED_ASTC_8x8_RGBA    // 2 bpp
	}

	enum TextureFilter : int32
	{
		POINT = 0,               // No filter, just pixel aproximation
		BILINEAR,                // Linear filtering
		TRILINEAR,               // Trilinear filtering (linear with mipmaps)
		ANISOTROPIC_4X,          // Anisotropic filtering 4x
		ANISOTROPIC_8X,          // Anisotropic filtering 8x
		ANISOTROPIC_16X,         // Anisotropic filtering 16x
	}

	enum TextureWrap : int32
	{
		REPEAT = 0,                // Repeats texture in tiled mode
		CLAMP,                     // Clamps texture to edge pixel in tiled mode
		MIRROR_REPEAT,             // Mirrors and repeats the texture in tiled mode
		MIRROR_CLAMP               // Mirrors and clamps to border the texture in tiled mode
	}

	enum CubemapLayout : int32
	{
		AUTO_DETECT = 0,         // Automatically detect layout type
		LINE_VERTICAL,           // Layout is defined by a vertical line with faces
		LINE_HORIZONTAL,         // Layout is defined by an horizontal line with faces
		CROSS_THREE_BY_FOUR,     // Layout is defined by a 3x4 cross with cubemap faces
		CROSS_FOUR_BY_THREE,     // Layout is defined by a 4x3 cross with cubemap faces
		PANORAMA                 // Layout is defined by a panorama image (equirectangular map)
	}

	enum FontType : int32
	{
		DEFAULT = 0,               // Default font generation, anti-aliased
		BITMAP,                    // Bitmap font generation, no anti-aliasing
		SDF                        // SDF font generation, requires external shader
	}

	enum BlendMode : int32
	{
		ALPHA = 0,                // Blend textures considering alpha (default)
		ADDITIVE,                 // Blend textures adding colors
		MULTIPLIED,               // Blend textures multiplying colors
		ADD_COLORS,               // Blend textures adding colors (alternative)
		SUBTRACT_COLORS,          // Blend textures subtracting colors (alternative)
		CUSTOM                    // Belnd textures using custom src/dst factors (use rlSetBlendMode())
	}

	enum Gesture : int32
	{
		NONE        = 0,        // No gesture
		TAP         = 1,        // Tap gesture
		DOUBLETAP   = 2,        // Double tap gesture
		HOLD        = 4,        // Hold gesture
		DRAG        = 8,        // Drag gesture
		SWIPE_RIGHT = 16,       // Swipe right gesture
		SWIPE_LEFT  = 32,       // Swipe left gesture
		SWIPE_UP    = 64,       // Swipe up gesture
		SWIPE_DOWN  = 128,      // Swipe down gesture
		PINCH_IN    = 256,      // Pinch in gesture
		PINCH_OUT   = 512       // Pinch out gesture
	}

	enum CameraMode : int32
	{
		CUSTOM = 0,              // Custom camera
		FREE,                    // Free camera
		ORBITAL,                 // Orbital camera
		FIRST_PERSON,            // First person camera
		THIRD_PERSON             // Third person camera
	}

	enum CameraProjection : int32
	{
		PERSPECTIVE = 0,         // Perspective projection
		ORTHOGRAPHIC             // Orthographic projection
	}

	enum NPatchLayout : int32
	{
		NINE_PATCH = 0,          // Npatch layout: 3x3 tiles
		THREE_PATCH_VERTICAL,    // Npatch layout: 1x3 tiles
		THREE_PATCH_HORIZONTAL   // Npatch layout: 3x1 tiles
	}

	// TODO(pJotoro): Add callbacks
	

	static
	{
		// Window-related functions
		[CLink]
		public static extern void InitWindow(int32 width, int32 height, char8* title);  // Initialize window and OpenGL context
		[CLink]
		public static extern bool WindowShouldClose();                               // Check if KEY_ESCAPE pressed or Close icon pressed
		[CLink]
		public static extern void CloseWindow();                                     // Close window and unload OpenGL context
		[CLink]
		public static extern bool IsWindowReady();                                   // Check if window has been initialized successfully
		[CLink]
		public static extern bool IsWindowFullscreen();                              // Check if window is currently fullscreen
		[CLink]
		public static extern bool IsWindowHidden();                                  // Check if window is currently hidden (only PLATFORM_DESKTOP)
		[CLink]
		public static extern bool IsWindowMinimized();                               // Check if window is currently minimized (only PLATFORM_DESKTOP)
		[CLink]
		public static extern bool IsWindowMaximized();                               // Check if window is currently maximized (only PLATFORM_DESKTOP)
		[CLink]
		public static extern bool IsWindowFocused();                                 // Check if window is currently focused (only PLATFORM_DESKTOP)
		[CLink]
		public static extern bool IsWindowResized();                                 // Check if window has been resized last frame
		[CLink]
		public static extern bool IsWindowState(uint32 flag);                      // Check if one specific window flag is enabled
		[CLink]
		public static extern void SetWindowState(uint32 flags);                    // Set window configuration state using flags
		[CLink]
		public static extern void ClearWindowState(uint32 flags);                  // Clear window configuration state flags
		[CLink]
		public static extern void ToggleFullscreen();                                // Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
		[CLink]
		public static extern void MaximizeWindow();                                  // Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
		[CLink]
		public static extern void MinimizeWindow();                                  // Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
		[CLink]
		public static extern void RestoreWindow();                                   // Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
		[CLink]
		public static extern void SetWindowIcon(Image image);                            // Set icon for window (only PLATFORM_DESKTOP)
		[CLink]
		public static extern void SetWindowTitle(char8* title);                     // Set title for window (only PLATFORM_DESKTOP)
		[CLink]
		public static extern void SetWindowPosition(int32 x, int32 y);                       // Set window position on screen (only PLATFORM_DESKTOP)
		[CLink]
		public static extern void SetWindowMonitor(int32 monitor);                         // Set monitor for the current window (fullscreen mode)
		[CLink]
		public static extern void SetWindowMinSize(int32 width, int32 height);               // Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
		[CLink]
		public static extern void SetWindowSize(int32 width, int32 height);                  // Set window dimensions
		[CLink]
		public static extern void* GetWindowHandle();                                // Get native window handle
		[CLink]
		public static extern int32 GetScreenWidth();                                   // Get current screen width
		[CLink]
		public static extern int32 GetScreenHeight();                                  // Get current screen height
		[CLink]
		public static extern int32 GetMonitorCount();                                  // Get number of connected monitors
		[CLink]
		public static extern int32 GetCurrentMonitor();                                // Get current connected monitor
		[CLink]
		public static extern Vector2 GetMonitorPosition(int32 monitor);                    // Get specified monitor position
		[CLink]
		public static extern int32 GetMonitorWidth(int32 monitor);                           // Get specified monitor width (max available by monitor)
		[CLink]
		public static extern int32 GetMonitorHeight(int32 monitor);                          // Get specified monitor height (max available by monitor)
		[CLink]
		public static extern int32 GetMonitorPhysicalWidth(int32 monitor);                   // Get specified monitor physical width in millimetres
		[CLink]
		public static extern int32 GetMonitorPhysicalHeight(int32 monitor);                  // Get specified monitor physical height in millimetres
		[CLink]
		public static extern int32 GetMonitorRefreshRate(int32 monitor);                     // Get specified monitor refresh rate
		[CLink]
		public static extern Vector2 GetWindowPosition();                            // Get window position XY on monitor
		[CLink]
		public static extern Vector2 GetWindowScaleDPI();                            // Get window scale DPI factor
		[CLink]
		public static extern char8* GetMonitorName(int32 monitor);                    // Get the human-readable, UTF-8 encoded name of the primary monitor
		[CLink]
		public static extern void SetClipboardText(char8* text);                    // Set clipboard text content
		[CLink]
		public static extern char8* GetClipboardText();                         // Get clipboard text content

		// Custom frame control functions
		// NOTE: Those functions are intended for advance users that want full control over the frame processing
		// By default EndDrawing() does this job: draws everything + SwapScreenBuffer() + manage frame timming + PollInputEvents()
		// To avoid that behaviour and control frame processes manually, enable in config.h: SUPPORT_CUSTOM_FRAME_CONTROL
		[CLink]
		public static extern void SwapScreenBuffer();                                // Swap back buffer with front buffer (screen drawing)
		[CLink]
		public static extern void PollInputEvents();                                 // Register all input events
		[CLink]
		public static extern void WaitTime(float ms);                                    // Wait for some milliseconds (halt program execution)

		// Cursor-related functions
		[CLink]
		public static extern void ShowCursor();                                      // Shows cursor
		[CLink]
		public static extern void HideCursor();                                      // Hides cursor
		[CLink]
		public static extern bool IsCursorHidden();                                  // Check if cursor is not visible
		[CLink]
		public static extern void EnableCursor();                                    // Enables cursor (unlock cursor)
		[CLink]
		public static extern void DisableCursor();                                   // Disables cursor (lock cursor)
		[CLink]
		public static extern bool IsCursorOnScreen();                                // Check if cursor is on the screen

		// Drawing-related functions
		[CLink]
		public static extern void ClearBackground(Color color);                          // Set background color (framebuffer clear color)
		[CLink]
		public static extern void BeginDrawing();                                    // Setup canvas (framebuffer) to start drawing
		[CLink]
		public static extern void EndDrawing();                                      // End canvas drawing and swap buffers (double buffering)
		[CLink]
		public static extern void BeginMode2D(Camera2D camera);                          // Begin 2D mode with custom camera (2D)
		[CLink]
		public static extern void EndMode2D();                                       // Ends 2D mode with custom camera
		[CLink]
		public static extern void BeginMode3D(Camera3D camera);                          // Begin 3D mode with custom camera (3D)
		[CLink]
		public static extern void EndMode3D();                                       // Ends 3D mode and returns to default 2D orthographic mode
		[CLink]
		public static extern void BeginTextureMode(RenderTexture2D target);              // Begin drawing to render texture
		[CLink]
		public static extern void EndTextureMode();                                  // Ends drawing to render texture
		[CLink]
		public static extern void BeginShaderMode(Shader shader);                        // Begin custom shader drawing
		[CLink]
		public static extern void EndShaderMode();                                   // End custom shader drawing (use default shader)
		[CLink]
		public static extern void BeginBlendMode(int32 mode);                              // Begin blending mode (alpha, additive, multiplied, subtract, custom)
		[CLink]
		public static extern void EndBlendMode();                                    // End blending mode (reset to default: alpha blending)
		[CLink]
		public static extern void BeginScissorMode(int32 x, int32 y, int32 width, int32 height); // Begin scissor mode (define screen area for following drawing)
		[CLink]
		public static extern void EndScissorMode();                                  // End scissor mode
		[CLink]
		public static extern void BeginVrStereoMode(VrStereoConfig config);              // Begin stereo rendering (requires VR simulator)
		[CLink]
		public static extern void EndVrStereoMode();                                 // End stereo rendering (requires VR simulator)

		// VR stereo config functions for VR simulator
		[CLink]
		public static extern VrStereoConfig LoadVrStereoConfig(VrDeviceInfo device);     // Load VR stereo config for VR simulator device parameters
		[CLink]
		public static extern void UnloadVrStereoConfig(VrStereoConfig config);           // Unload VR stereo config

		// Shader management functions
		// NOTE: Shader functionality is not available on OpenGL 1.1
		// Shader management functions
		// NOTE: Shader functionality is not available on OpenGL 1.1
		[CLink]
		public static extern Shader LoadShader(char8* vsFileName, char8* fsFileName);   // Load shader from files and bind default locations
		[CLink]
		public static extern Shader LoadShaderFromMemory(char8* vsCode, char8* fsCode); // Load shader from code strings and bind default locations
		[CLink]
		public static extern int GetShaderLocation(Shader shader, char8* uniformName);       // Get shader uniform location
		[CLink]
		public static extern int GetShaderLocationAttrib(Shader shader, char8* attribName);  // Get shader attribute location
		[CLink]
		public static extern void SetShaderValue(Shader shader, int32 locIndex, void *value, int32 uniformType);               // Set shader uniform value
		[CLink]
		public static extern void SetShaderValueV(Shader shader, int32 locIndex, void *value, int32 uniformType, int32 count);   // Set shader uniform value vector
		[CLink]
		public static extern void SetShaderValueMatrix(Shader shader, int32 locIndex, Matrix mat);         // Set shader uniform value (matrix 4x4)
		[CLink]
		public static extern void SetShaderValueTexture(Shader shader, int32 locIndex, Texture2D texture); // Set shader uniform value for texture (sampler2d)
		[CLink]
		public static extern void UnloadShader(Shader shader);                                    // Unload shader from GPU memory (VRAM)

		// Screen-space-related functions
		[CLink]
		public static extern Ray GetMouseRay(Vector2 mousePosition, Camera camera);      // Get a ray trace from mouse position
		[CLink]
		public static extern Matrix GetCameraMatrix(Camera camera);                      // Get camera transform matrix (view matrix)
		[CLink]
		public static extern Matrix GetCameraMatrix2D(Camera2D camera);                  // Get camera 2d transform matrix
		[CLink]
		public static extern Vector2 GetWorldToScreen(Vector3 position, Camera camera);  // Get the screen space position for a 3d world space position
		[CLink]
		public static extern Vector2 GetWorldToScreenEx(Vector3 position, Camera camera, int32 width, int32 height); // Get size position for a 3d world space position
		[CLink]
		public static extern Vector2 GetWorldToScreen2D(Vector2 position, Camera2D camera); // Get the screen space position for a 2d camera world space position
		[CLink]
		public static extern Vector2 GetScreenToWorld2D(Vector2 position, Camera2D camera); // Get the world space position for a 2d camera screen space position

		// Timing-related functions
		[CLink]
		public static extern void SetTargetFPS(int32 fps);                                 // Set target FPS (maximum)
		[CLink]
		public static extern int32 GetFPS();                                           // Get current FPS
		[CLink]
		public static extern float GetFrameTime();                                   // Get time in seconds for last frame drawn (delta time)
		[CLink]
		public static extern double GetTime();                                       // Get elapsed time in seconds since InitWindow()

		// Misc. functions
		[CLink]
		public static extern int32 GetRandomValue(int32 min, int32 max);                       // Get a random value between min and max (both included)
		[CLink]
		public static extern void SetRandomSeed(uint32 seed);                      // Set the seed for the random number generator
		[CLink]
		public static extern void TakeScreenshot(char8* fileName);                  // Takes a screenshot of current screen (filename extension defines format)
		[CLink]
		public static extern void SetConfigFlags(uint32 flags);                    // Setup init configuration flags (view FLAGS)

		[CLink]
		public static extern void TraceLog(int32 logLevel, char8* text, ...);         // Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
		[CLink]
		public static extern void SetTraceLogLevel(int32 logLevel);                        // Set the current threshold (minimum) log level
		[CLink]
		public static extern void *MemAlloc(int32 size);                                   // Internal memory allocator
		[CLink]
		public static extern void *MemRealloc(void* ptr, int32 size);                      // Internal memory reallocator
		[CLink]
		public static extern void MemFree(void* ptr);                                    // Internal memory free

		// TODO(pJotoro): Add callback functions

		// Files management functions
		[CLink]
		public static extern uint8* LoadFileData(char8* fileName, uint32* bytesRead);     // Load file data as byte array (read)
		[CLink]
		public static extern void UnloadFileData(uint8* data);                   // Unload file data allocated by LoadFileData()
		[CLink]
		public static extern bool SaveFileData(char8* fileName, void* data, uint32 bytesToWrite); // Save data to file from byte array (write), returns true on success
		[CLink]
		public static extern char8* LoadFileText(char8* fileName);                   // Load text data from file (read), returns a '\0' terminated string
		[CLink]
		public static extern void UnloadFileText(char8* text);                            // Unload file text data allocated by LoadFileText()
		[CLink]
		public static extern bool SaveFileText(char8* fileName, char8* text);        // Save text data to file (write), string must be '\0' terminated, returns true on success
		[CLink]
		public static extern bool FileExists(char8* fileName);                      // Check if file exists
		[CLink]
		public static extern bool DirectoryExists(char8* dirPath);                  // Check if a directory path exists
		[CLink]
		public static extern bool IsFileExtension(char8* fileName, char8* ext);// Check file extension (including point: .png, .wav)
		[CLink]
		public static extern char8* GetFileExtension(char8* fileName);         // Get pointer to extension for a filename string (includes dot: '.png')
		[CLink]
		public static extern char8* GetFileName(char8* filePath);              // Get pointer to filename for a path string
		[CLink]
		public static extern char8* GetFileNameWithoutExt(char8* filePath);    // Get filename string without extension (uses static string)
		[CLink]
		public static extern char8* GetDirectoryPath(char8* filePath);         // Get full path for a given fileName with path (uses static string)
		[CLink]
		public static extern char8* GetPrevDirectoryPath(char8* dirPath);      // Get previous directory path for a given path (uses static string)
		[CLink]
		public static extern char8* GetWorkingDirectory();                      // Get current working directory (uses static string)
		[CLink]
		public static extern char8** GetDirectoryFiles(char8* dirPath, int32* count);  // Get filenames in a directory path (memory should be freed)
		[CLink]
		public static extern void ClearDirectoryFiles();                             // Clear directory files paths buffers (free memory)
		[CLink]
		public static extern bool ChangeDirectory(char8* dir);                      // Change working directory, return true on success
		[CLink]
		public static extern bool IsFileDropped();                                   // Check if a file has been dropped into window
		[CLink]
		public static extern char8** GetDroppedFiles(int32* count);                         // Get dropped files names (memory should be freed)
		[CLink]
		public static extern void ClearDroppedFiles();                               // Clear dropped files paths buffer (free memory)
		[CLink]
		public static extern int64 GetFileModTime(char8* fileName);                  // Get file modification time (last write time)

		// Compression/Encoding functionality
		[CLink]
		public static extern uint8* CompressData(uint8* data, int32 dataLength, int32* compDataLength);        // Compress data (DEFLATE algorithm)
		[CLink]
		public static extern uint8* DecompressData(uint8* compData, int32 compDataLength, int32* dataLength);  // Decompress data (DEFLATE algorithm)
		[CLink]
		public static extern char8* EncodeDataBase64(uint8* data, int32 dataLength, int32* outputLength);         // Encode data to Base64 string
		[CLink]
		public static extern uint8* DecodeDataBase64(uint8* data, int32* outputLength);                      // Decode Base64 string data

		// Persistent storage management
		[CLink]
		public static extern bool SaveStorageValue(uint32 position, int32 value);    // Save integer value to storage file (to defined position), returns true on success
		[CLink]
		public static extern int32 LoadStorageValue(uint32 position);                // Load integer value from storage file (from defined position)

		[CLink]
		public static extern void OpenURL(char8* url);                              // Open URL with default system browser (if available)

		//------------------------------------------------------------------------------------
		// Input Handling Functions (Module: core)
		//------------------------------------------------------------------------------------

		// Input-related functions: keyboard
		[CLink]
		public static extern bool IsKeyPressed(int32 key);                             // Check if a key has been pressed once
		[CLink]
		public static extern bool IsKeyDown(int32 key);                                // Check if a key is being pressed
		[CLink]
		public static extern bool IsKeyReleased(int32 key);                            // Check if a key has been released once
		[CLink]
		public static extern bool IsKeyUp(int32 key);                                  // Check if a key is NOT being pressed
		[CLink]
		public static extern void SetExitKey(int32 key);                               // Set a custom key to exit program (default is ESC)
		[CLink]
		public static extern int32 GetKeyPressed();                                // Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
		[CLink]
		public static extern int32 GetCharPressed();                               // Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty

		// Input-related functions: gamepads
		[CLink]
		public static extern bool IsGamepadAvailable(int32 gamepad);                   // Check if a gamepad is available
		[CLink]
		public static extern char8* GetGamepadName(int32 gamepad);                // Get gamepad internal name id
	 	[CLink]
		public static extern bool IsGamepadButtonPressed(int32 gamepad, int32 button);   // Check if a gamepad button has been pressed once
		[CLink]
		public static extern bool IsGamepadButtonDown(int32 gamepad, int32 button);      // Check if a gamepad button is being pressed
		[CLink]
		public static extern bool IsGamepadButtonReleased(int32 gamepad, int32 button);  // Check if a gamepad button has been released once
		[CLink]
		public static extern bool IsGamepadButtonUp(int32 gamepad, int32 button);        // Check if a gamepad button is NOT being pressed
		[CLink]
		public static extern int32 GetGamepadButtonPressed();                      // Get the last gamepad button pressed
		[CLink]
		public static extern int32 GetGamepadAxisCount(int32 gamepad);                   // Get gamepad axis count for a gamepad
		[CLink]
		public static extern float GetGamepadAxisMovement(int32 gamepad, int32 axis);    // Get axis movement value for a gamepad axis
		[CLink]
		public static extern int32 SetGamepadMappings(char8* mappings);           // Set internal gamepad mappings (SDL_GameControllerDB)

		// Input-related functions: mouse
		[CLink]
		public static extern bool IsMouseButtonPressed(int32 button);                  // Check if a mouse button has been pressed once
		[CLink]
		public static extern bool IsMouseButtonDown(int32 button);                     // Check if a mouse button is being pressed
		[CLink]
		public static extern bool IsMouseButtonReleased(int32 button);                 // Check if a mouse button has been released once
		[CLink]
		public static extern bool IsMouseButtonUp(int32 button);                       // Check if a mouse button is NOT being pressed
		[CLink]
		public static extern int32 GetMouseX();                                    // Get mouse position X
		[CLink]
		public static extern int32 GetMouseY();                                    // Get mouse position Y
		[CLink]
		public static extern Vector2 GetMousePosition();                         // Get mouse position XY
		[CLink]
		public static extern Vector2 GetMouseDelta();                            // Get mouse delta between frames
		[CLink]
		public static extern void SetMousePosition(int32 x, int32 y);                    // Set mouse position XY
		[CLink]
		public static extern void SetMouseOffset(int32 offsetX, int32 offsetY);          // Set mouse offset
		[CLink]
		public static extern void SetMouseScale(float scaleX, float scaleY);         // Set mouse scaling
		[CLink]
		public static extern float GetMouseWheelMove();                          // Get mouse wheel movement Y
		[CLink]
		public static extern void SetMouseCursor(int32 cursor);                        // Set mouse cursor

		// Input-related functions: touch
		[CLink]
		public static extern int32 GetTouchX();                                    // Get touch position X for touch point 0 (relative to screen size)
		[CLink]
		public static extern int32 GetTouchY();                                    // Get touch position Y for touch point 0 (relative to screen size)
		[CLink]
		public static extern Vector2 GetTouchPosition(int32 index);                    // Get touch position XY for a touch point index (relative to screen size)
		[CLink]
		public static extern int32 GetTouchPointId(int32 index);                         // Get touch point identifier for given index
		[CLink]
		public static extern int32 GetTouchPointCount();                           // Get number of touch points

		//------------------------------------------------------------------------------------
		// Gestures and Touch Handling Functions (Module: rgestures)
		//------------------------------------------------------------------------------------
		[CLink]
		public static extern void SetGesturesEnabled(uint32 flags);      // Enable a set of gestures using flags
		[CLink]
		public static extern bool IsGestureDetected(int32 gesture);              // Check if a gesture have been detected
		[CLink]
		public static extern int32 GetGestureDetected();                     // Get latest detected gesture
		[CLink]
		public static extern float GetGestureHoldDuration();               // Get gesture hold time in milliseconds
		[CLink]
		public static extern Vector2 GetGestureDragVector();               // Get gesture drag vector
		[CLink]
		public static extern float GetGestureDragAngle();                  // Get gesture drag angle
		[CLink]
		public static extern Vector2 GetGesturePinchVector();              // Get gesture pinch delta
		[CLink]
		public static extern float GetGesturePinchAngle();                 // Get gesture pinch angle

		//------------------------------------------------------------------------------------
		// Camera System Functions (Module: rcamera)
		//------------------------------------------------------------------------------------
		[CLink]
		public static extern void SetCameraMode(Camera camera, int32 mode);      // Set camera mode (multiple camera modes available)
		[CLink]
		public static extern void UpdateCamera(Camera *camera);                // Update camera position for selected mode

		[CLink]
		public static extern void SetCameraPanControl(int32 keyPan);             // Set camera pan key to combine with mouse movement (free camera)
		[CLink]
		public static extern void SetCameraAltControl(int32 keyAlt);             // Set camera alt key to combine with mouse movement (free camera)
		[CLink]
		public static extern void SetCameraSmoothZoomControl(int32 keySmoothZoom); // Set camera smooth zoom key to combine with mouse (free camera)
		[CLink]
		public static extern void SetCameraMoveControls(int32 keyFront, int32 keyBack, int32 keyRight, int32 keyLeft, int32 keyUp, int32 keyDown); // Set camera move controls (1st person and 3rd person cameras)

		//------------------------------------------------------------------------------------
		// Basic Shapes Drawing Functions (Module: shapes)
		//------------------------------------------------------------------------------------
		// Set texture and rectangle to be used on shapes drawing
		// NOTE: It can be useful when using basic shapes and one single font,
		// defining a font char white rectangle would allow drawing everything in a single draw call
		[CLink]
		public static extern void SetShapesTexture(Texture2D texture, Rectangle source);       // Set texture and rectangle to be used on shapes drawing

		// Basic shapes drawing functions
		[CLink]
		public static extern void DrawPixel(int32 posX, int32 posY, Color color);                                                   // Draw a pixel
		[CLink]
		public static extern void DrawPixelV(Vector2 position, Color color);                                                    // Draw a pixel (Vector version)
		[CLink]
		public static extern void DrawLine(int32 startPosX, int32 startPosY, int32 endPosX, int32 endPosY, Color color);                // Draw a line
		[CLink]
		public static extern void DrawLineV(Vector2 startPos, Vector2 endPos, Color color);                                     // Draw a line (Vector version)
		[CLink]
		public static extern void DrawLineEx(Vector2 startPos, Vector2 endPos, float thick, Color color);                       // Draw a line defining thickness
		[CLink]
		public static extern void DrawLineBezier(Vector2 startPos, Vector2 endPos, float thick, Color color);                   // Draw a line using cubic-bezier curves in-out
		[CLink]
		public static extern void DrawLineBezierQuad(Vector2 startPos, Vector2 endPos, Vector2 controlPos, float thick, Color color); // Draw line using quadratic bezier curves with a control point
		[CLink]
		public static extern void DrawLineBezierCubic(Vector2 startPos, Vector2 endPos, Vector2 startControlPos, Vector2 endControlPos, float thick, Color color); // Draw line using cubic bezier curves with 2 control points
		[CLink]
		public static extern void DrawLineStrip(Vector2 *points, int32 pointCount, Color color);                                  // Draw lines sequence
		[CLink]
		public static extern void DrawCircle(int32 centerX, int32 centerY, float radius, Color color);                              // Draw a color-filled circle
		[CLink]
		public static extern void DrawCircleSector(Vector2 center, float radius, float startAngle, float endAngle, int32 segments, Color color);      // Draw a piece of a circle
		[CLink]
		public static extern void DrawCircleSectorLines(Vector2 center, float radius, float startAngle, float endAngle, int32 segments, Color color); // Draw circle sector outline
		[CLink]
		public static extern void DrawCircleGradient(int32 centerX, int32 centerY, float radius, Color color1, Color color2);       // Draw a gradient-filled circle
		[CLink]
		public static extern void DrawCircleV(Vector2 center, float radius, Color color);                                       // Draw a color-filled circle (Vector version)
		[CLink]
		public static extern void DrawCircleLines(int32 centerX, int32 centerY, float radius, Color color);                         // Draw circle outline
		[CLink]
		public static extern void DrawEllipse(int32 centerX, int32 centerY, float radiusH, float radiusV, Color color);             // Draw ellipse
		[CLink]
		public static extern void DrawEllipseLines(int32 centerX, int32 centerY, float radiusH, float radiusV, Color color);        // Draw ellipse outline
		[CLink]
		public static extern void DrawRing(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int32 segments, Color color); // Draw ring
		[CLink]
		public static extern void DrawRingLines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int32 segments, Color color);    // Draw ring outline
		[CLink]
		public static extern void DrawRectangle(int32 posX, int32 posY, int32 width, int32 height, Color color);                        // Draw a color-filled rectangle
		[CLink]
		public static extern void DrawRectangleV(Vector2 position, Vector2 size, Color color);                                  // Draw a color-filled rectangle (Vector version)
		[CLink]
		public static extern void DrawRectangleRec(Rectangle rec, Color color);                                                 // Draw a color-filled rectangle
		[CLink]
		public static extern void DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);                 // Draw a color-filled rectangle with pro parameters
		[CLink]
		public static extern void DrawRectangleGradientV(int32 posX, int32 posY, int32 width, int32 height, Color color1, Color color2);// Draw a vertical-gradient-filled rectangle
		[CLink]
		public static extern void DrawRectangleGradientH(int32 posX, int32 posY, int32 width, int32 height, Color color1, Color color2);// Draw a horizontal-gradient-filled rectangle
		[CLink]
		public static extern void DrawRectangleGradientEx(Rectangle rec, Color col1, Color col2, Color col3, Color col4);       // Draw a gradient-filled rectangle with custom vertex colors
		[CLink]
		public static extern void DrawRectangleLines(int32 posX, int32 posY, int32 width, int32 height, Color color);                   // Draw rectangle outline
		[CLink]
		public static extern void DrawRectangleLinesEx(Rectangle rec, float lineThick, Color color);                            // Draw rectangle outline with extended parameters
		[CLink]
		public static extern void DrawRectangleRounded(Rectangle rec, float roundness, int32 segments, Color color);              // Draw rectangle with rounded edges
		[CLink]
		public static extern void DrawRectangleRoundedLines(Rectangle rec, float roundness, int32 segments, float lineThick, Color color); // Draw rectangle with rounded edges outline
		[CLink]
		public static extern void DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                                // Draw a color-filled triangle (vertex in counter-clockwise order!)
		[CLink]
		public static extern void DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                           // Draw triangle outline (vertex in counter-clockwise order!)
		[CLink]
		public static extern void DrawTriangleFan(Vector2* points, int32 pointCount, Color color);                                // Draw a triangle fan defined by points (first vertex is the center)
		[CLink]
		public static extern void DrawTriangleStrip(Vector2* points, int32 pointCount, Color color);                              // Draw a triangle strip defined by points
		[CLink]
		public static extern void DrawPoly(Vector2 center, int32 sides, float radius, float rotation, Color color);               // Draw a regular polygon (Vector version)
		[CLink]
		public static extern void DrawPolyLines(Vector2 center, int32 sides, float radius, float rotation, Color color);          // Draw a polygon outline of n sides
		[CLink]
		public static extern void DrawPolyLinesEx(Vector2 center, int32 sides, float radius, float rotation, float lineThick, Color color); // Draw a polygon outline of n sides with extended parameters

		// Basic shapes collision detection functions
		[CLink]
		public static extern bool CheckCollisionRecs(Rectangle rec1, Rectangle rec2);                                           // Check collision between two rectangles
		[CLink]
		public static extern bool CheckCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2);        // Check collision between two circles
		[CLink]
		public static extern bool CheckCollisionCircleRec(Vector2 center, float radius, Rectangle rec);                         // Check collision between circle and rectangle
		[CLink]
		public static extern bool CheckCollisionPointRec(Vector2 point, Rectangle rec);                                         // Check if point is inside rectangle
		[CLink]
		public static extern bool CheckCollisionPointCircle(Vector2 point, Vector2 center, float radius);                       // Check if point is inside circle
		[CLink]
		public static extern bool CheckCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3);               // Check if point is inside a triangle
		[CLink]
		public static extern bool CheckCollisionLines(Vector2 startPos1, Vector2 endPos1, Vector2 startPos2, Vector2 endPos2, Vector2 *collisionPoint); // Check the collision between two lines defined by two points each, returns collision point by reference
		[CLink]
		public static extern bool CheckCollisionPointLine(Vector2 point, Vector2 p1, Vector2 p2, int32 threshold);                // Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
		[CLink]
		public static extern Rectangle GetCollisionRec(Rectangle rec1, Rectangle rec2);                                         // Get collision rectangle for two rectangles collision

		//------------------------------------------------------------------------------------
		// Texture Loading and Drawing Functions (Module: textures)
		//------------------------------------------------------------------------------------

		// Image loading functions
		// NOTE: This functions do not require GPU access
		[CLink]
		public static extern Image LoadImage(char8* fileName);                                                             // Load image from file into CPU memory (RAM)
		[CLink]
		public static extern Image LoadImageRaw(char8* fileName, int32 width, int32 height, int32 format, int32 headerSize);       // Load image from RAW file data
		[CLink]
		public static extern Image LoadImageAnim(char8* fileName, int32* frames);                                            // Load image sequence from file (frames appended to image.data)
		[CLink]
		public static extern Image LoadImageFromMemory(char8* fileType, uint8* fileData, int32 dataSize);      // Load image from memory buffer, fileType refers to extension: i.e. '.png'
		[CLink]
		public static extern Image LoadImageFromTexture(Texture2D texture);                                                     // Load image from GPU texture data
		[CLink]
		public static extern Image LoadImageFromScreen();                                                                   // Load image from screen buffer and (screenshot)
		[CLink]
		public static extern void UnloadImage(Image image);                                                                     // Unload image from CPU memory (RAM)
		[CLink]
		public static extern bool ExportImage(Image image, char8* fileName);                                               // Export image data to file, returns true on success
		[CLink]
		public static extern bool ExportImageAsCode(Image image, char8* fileName);                                         // Export image as code file defining an array of bytes, returns true on success

		// Image generation functions
		[CLink]
		public static extern Image GenImageColor(int32 width, int32 height, Color color);                                           // Generate image: plain color
		[CLink]
		public static extern Image GenImageGradientV(int32 width, int32 height, Color top, Color bottom);                           // Generate image: vertical gradient
		[CLink]
		public static extern Image GenImageGradientH(int32 width, int32 height, Color left, Color right);                           // Generate image: horizontal gradient
		[CLink]
		public static extern Image GenImageGradientRadial(int32 width, int32 height, float density, Color inner, Color outer);      // Generate image: radial gradient
		[CLink]
		public static extern Image GenImageChecked(int32 width, int32 height, int32 checksX, int32 checksY, Color col1, Color col2);    // Generate image: checked
		[CLink]
		public static extern Image GenImageWhiteNoise(int32 width, int32 height, float factor);                                     // Generate image: white noise
		[CLink]
		public static extern Image GenImageCellular(int32 width, int32 height, int32 tileSize);                                       // Generate image: cellular algorithm, bigger tileSize means bigger cells

		// Image manipulation functions
		[CLink]
		public static extern Image ImageCopy(Image image);                                                                      // Create an image duplicate (useful for transformations)
		[CLink]
		public static extern Image ImageFromImage(Image image, Rectangle rec);                                                  // Create an image from another image piece
		[CLink]
		public static extern Image ImageText(char8* text, int32 fontSize, Color color);                                      // Create an image from text (default font)
		[CLink]
		public static extern Image ImageTextEx(Font font, char8* text, float fontSize, float spacing, Color tint);         // Create an image from text (custom sprite font)
		[CLink]
		public static extern void ImageFormat(Image* image, int32 newFormat);                                                     // Convert image data to desired format
		[CLink]
		public static extern void ImageToPOT(Image* image, Color fill);                                                         // Convert image to POT (power-of-two)
		[CLink]
		public static extern void ImageCrop(Image* image, Rectangle crop);                                                      // Crop an image to a defined rectangle
		[CLink]
		public static extern void ImageAlphaCrop(Image* image, float threshold);                                                // Crop image depending on alpha value
		[CLink]
		public static extern void ImageAlphaClear(Image* image, Color color, float threshold);                                  // Clear alpha channel to desired color
		[CLink]
		public static extern void ImageAlphaMask(Image* image, Image alphaMask);                                                // Apply alpha mask to image
		[CLink]
		public static extern void ImageAlphaPremultiply(Image* image);                                                          // Premultiply alpha channel
		[CLink]
		public static extern void ImageResize(Image* image, int32 newWidth, int32 newHeight);                                       // Resize image (Bicubic scaling algorithm)
		[CLink]
		public static extern void ImageResizeNN(Image* image, int32 newWidth,int32 newHeight);                                      // Resize image (Nearest-Neighbor scaling algorithm)
		[CLink]
		public static extern void ImageResizeCanvas(Image* image, int32 newWidth, int32 newHeight, int32 offsetX, int32 offsetY, Color fill);  // Resize canvas and fill with color
		[CLink]
		public static extern void ImageMipmaps(Image* image);                                                                   // Compute all mipmap levels for a provided image
		[CLink]
		public static extern void ImageDither(Image* image, int32 rBpp, int32 gBpp, int32 bBpp, int32 aBpp);                            // Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
		[CLink]
		public static extern void ImageFlipVertical(Image* image);                                                              // Flip image vertically
		[CLink]
		public static extern void ImageFlipHorizontal(Image* image);                                                            // Flip image horizontally
		[CLink]
		public static extern void ImageRotateCW(Image* image);                                                                  // Rotate image clockwise 90deg
		[CLink]
		public static extern void ImageRotateCCW(Image* image);                                                                 // Rotate image counter-clockwise 90deg
		[CLink]
		public static extern void ImageColorTint(Image* image, Color color);                                                    // Modify image color: tint
		[CLink]
		public static extern void ImageColorInvert(Image* image);                                                               // Modify image color: invert
		[CLink]
		public static extern void ImageColorGrayscale(Image* image);                                                            // Modify image color: grayscale
		[CLink]
		public static extern void ImageColorContrast(Image* image, float contrast);                                             // Modify image color: contrast (-100 to 100)
		[CLink]
		public static extern void ImageColorBrightness(Image* image, int32 brightness);                                           // Modify image color: brightness (-255 to 255)
		[CLink]
		public static extern void ImageColorReplace(Image* image, Color color, Color replace);                                  // Modify image color: replace color
		[CLink]
		public static extern Color* LoadImageColors(Image image);                                                               // Load color data from image as a Color array (RGBA - 32bit)
		[CLink]
		public static extern Color* LoadImagePalette(Image image, int32 maxPaletteSize, int32* colorCount);                         // Load colors palette from image as a Color array (RGBA - 32bit)
		[CLink]
		public static extern void UnloadImageColors(Color *colors);                                                             // Unload color data loaded with LoadImageColors()
		[CLink]
		public static extern void UnloadImagePalette(Color *colors);                                                            // Unload colors palette loaded with LoadImagePalette()
		[CLink]
		public static extern Rectangle GetImageAlphaBorder(Image image, float threshold);                                       // Get image alpha border rectangle
		[CLink]
		public static extern Color GetImageColor(Image image, int32 x, int32 y);                                                    // Get image pixel color at (x, y) position

		// Image drawing functions
		// NOTE: Image software-rendering functions (CPU)
		[CLink]
		public static extern void ImageClearBackground(Image* dst, Color color);                                                // Clear image background with given color
		[CLink]
		public static extern void ImageDrawPixel(Image* dst, int32 posX, int32 posY, Color color);                                  // Draw pixel within an image
		[CLink]
		public static extern void ImageDrawPixelV(Image* dst, Vector2 position, Color color);                                   // Draw pixel within an image (Vector version)
		[CLink]
		public static extern void ImageDrawLine(Image* dst, int32 startPosX, int32 startPosY, int32 endPosX, int32 endPosY, Color color); // Draw line within an image
		[CLink]
		public static extern void ImageDrawLineV(Image* dst, Vector2 start, Vector2 end, Color color);                          // Draw line within an image (Vector version)
		[CLink]
		public static extern void ImageDrawCircle(Image* dst, int32 centerX, int32 centerY, int32 radius, Color color);               // Draw circle within an image
		[CLink]
		public static extern void ImageDrawCircleV(Image* dst, Vector2 center, int32 radius, Color color);                        // Draw circle within an image (Vector version)
		[CLink]
		public static extern void ImageDrawRectangle(Image* dst, int32 posX, int32 posY, int32 width, int32 height, Color color);       // Draw rectangle within an image
		[CLink]
		public static extern void ImageDrawRectangleV(Image* dst, Vector2 position, Vector2 size, Color color);                 // Draw rectangle within an image (Vector version)
		[CLink]
		public static extern void ImageDrawRectangleRec(Image* dst, Rectangle rec, Color color);                                // Draw rectangle within an image
		[CLink]
		public static extern void ImageDrawRectangleLines(Image* dst, Rectangle rec, int thick, Color color);                   // Draw rectangle lines within an image
		[CLink]
		public static extern void ImageDraw(Image* dst, Image src, Rectangle srcRec, Rectangle dstRec, Color tint);             // Draw a source image within a destination image (tint applied to source)
		[CLink]
		public static extern void ImageDrawText(Image* dst, char8* text, int32 posX, int32 posY, int32 fontSize, Color color);   // Draw text (using default font) within an image (destination)
		[CLink]
		public static extern void ImageDrawTextEx(Image* dst, Font font, char8* text, Vector2 position, float fontSize, float spacing, Color tint); // Draw text (custom sprite font) within an image (destination)

		// Texture loading functions
		// NOTE: These functions require GPU access
		[CLink]
		public static extern Texture2D LoadTexture(char8* fileName);                                                       // Load texture from file into GPU memory (VRAM)
		[CLink]
		public static extern Texture2D LoadTextureFromImage(Image image);                                                       // Load texture from image data
		[CLink]
		public static extern TextureCubemap LoadTextureCubemap(Image image, int32 layout);                                        // Load cubemap from image, multiple image cubemap layouts supported
		[CLink]
		public static extern RenderTexture2D LoadRenderTexture(int32 width, int32 height);                                          // Load texture for rendering (framebuffer)
		[CLink]
		public static extern void UnloadTexture(Texture2D texture);                                                             // Unload texture from GPU memory (VRAM)
		[CLink]
		public static extern void UnloadRenderTexture(RenderTexture2D target);                                                  // Unload render texture from GPU memory (VRAM)
		[CLink]
		public static extern void UpdateTexture(Texture2D texture, void* pixels);                                         // Update GPU texture with new data
		[CLink]
		public static extern void UpdateTextureRec(Texture2D texture, Rectangle rec, void* pixels);                       // Update GPU texture rectangle with new data

		// Texture configuration functions
		[CLink]
		public static extern void GenTextureMipmaps(Texture2D* texture);                                                        // Generate GPU mipmaps for a texture
		[CLink]
		public static extern void SetTextureFilter(Texture2D texture, int32 filter);                                              // Set texture scaling filter mode
		[CLink]
		public static extern void SetTextureWrap(Texture2D texture, int32 wrap);                                                  // Set texture wrapping mode

		// Texture drawing functions
		[CLink]
		public static extern void DrawTexture(Texture2D texture, int32 posX, int32 posY, Color tint);                               // Draw a Texture2D
		[CLink]
		public static extern void DrawTextureV(Texture2D texture, Vector2 position, Color tint);                                // Draw a Texture2D with position defined as Vector2
		[CLink]
		public static extern void DrawTextureEx(Texture2D texture, Vector2 position, float rotation, float scale, Color tint);  // Draw a Texture2D with extended parameters
		[CLink]
		public static extern void DrawTextureRec(Texture2D texture, Rectangle source, Vector2 position, Color tint);            // Draw a part of a texture defined by a rectangle
		[CLink]
		public static extern void DrawTextureQuad(Texture2D texture, Vector2 tiling, Vector2 offset, Rectangle quad, Color tint);  // Draw texture quad with tiling and offset parameters
		[CLink]
		public static extern void DrawTextureTiled(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, float scale, Color tint);      // Draw part of a texture (defined by a rectangle) with rotation and scale tiled into dest.
		[CLink]
		public static extern void DrawTexturePro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint);           // Draw a part of a texture defined by a rectangle with 'pro' parameters
		[CLink]
		public static extern void DrawTextureNPatch(Texture2D texture, NPatchInfo nPatchInfo, Rectangle dest, Vector2 origin, float rotation, Color tint);   // Draws a texture (or part of it) that stretches or shrinks nicely
		[CLink]
		public static extern void DrawTexturePoly(Texture2D texture, Vector2 center, Vector2 *points, Vector2 *texcoords, int32 pointCount, Color tint);      // Draw a textured polygon

		// Color/pixel related functions
		[CLink]
		public static extern Color Fade(Color color, float alpha);                                 // Get color with alpha applied, alpha goes from 0.0f to 1.0f
		[CLink]
		public static extern int32 ColorToInt(Color color);                                          // Get hexadecimal value for a Color
		[CLink]
		public static extern Vector4 ColorNormalize(Color color);                                  // Get Color normalized as float [0..1]
		[CLink]
		public static extern Color ColorFromNormalized(Vector4 normalized);                        // Get Color from normalized values [0..1]
		[CLink]
		public static extern Vector3 ColorToHSV(Color color);                                      // Get HSV values for a Color, hue [0..360], saturation/value [0..1]
		[CLink]
		public static extern Color ColorFromHSV(float hue, float saturation, float value);         // Get a Color from HSV values, hue [0..360], saturation/value [0..1]
		[CLink]
		public static extern Color ColorAlpha(Color color, float alpha);                           // Get color with alpha applied, alpha goes from 0.0f to 1.0f
		[CLink]
		public static extern Color ColorAlphaBlend(Color dst, Color src, Color tint);              // Get src alpha-blended into dst color with tint
		[CLink]
		public static extern Color GetColor(uint32 hexValue);                                // Get Color structure from hexadecimal value
		[CLink]
		public static extern Color GetPixelColor(void* srcPtr, int32 format);                        // Get Color from a source pixel pointer of certain format
		[CLink]
		public static extern void SetPixelColor(void* dstPtr, Color color, int32 format);            // Set color formatted into destination pixel pointer
		[CLink]
		public static extern int32 GetPixelDataSize(int32 width, int32 height, int32 format);              // Get pixel data size in bytes for certain format

		//------------------------------------------------------------------------------------
		// Font Loading and Text Drawing Functions (Module: text)
		//------------------------------------------------------------------------------------

		// Font loading/unloading functions
		[CLink]
		public static extern Font GetFontDefault();                                                            // Get the default Font
		[CLink]
		public static extern Font LoadFont(char8* fileName);                                                  // Load font from file into GPU memory (VRAM)
		[CLink]
		public static extern Font LoadFontEx(char8* fileName, int32 fontSize, int32* fontChars, int32 glyphCount);  // Load font from file with extended parameters
		[CLink]
		public static extern Font LoadFontFromImage(Image image, Color key, int32 firstChar);                        // Load font from Image (XNA style)
		[CLink]
		public static extern Font LoadFontFromMemory(char8* fileType, uint8* fileData, int32 dataSize, int32 fontSize, int32* fontChars, int32 glyphCount); // Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
		[CLink]
		public static extern GlyphInfo *LoadFontData(uint8* fileData, int32 dataSize, int32 fontSize, int32* fontChars, int32 glyphCount, int32 type);      // Load font data for further use
		[CLink]
		public static extern Image GenImageFontAtlas(GlyphInfo* chars, Rectangle** recs, int32 glyphCount, int32 fontSize, int32 padding, int32 packMethod);      // Generate image font atlas using chars info
		[CLink]
		public static extern void UnloadFontData(GlyphInfo *chars, int32 glyphCount);                                 // Unload font chars info data (RAM)
		[CLink]
		public static extern void UnloadFont(Font font);                                                           // Unload Font from GPU memory (VRAM)

		// Text drawing functions
		[CLink]
		public static extern void DrawFPS(int32 posX, int32 posY);                                                     // Draw current FPS
		[CLink]
		public static extern void DrawText(char8* text, int32 posX, int32 posY, int32 fontSize, Color color);       // Draw text (using default font)
		[CLink]
		public static extern void DrawTextEx(Font font, char8* text, Vector2 position, float fontSize, float spacing, Color tint);    // Draw text using font and additional parameters
		[CLink]
		public static extern void DrawTextPro(Font font, char8* text, Vector2 position, Vector2 origin, float rotation, float fontSize, float spacing, Color tint); // Draw text using Font and pro parameters (rotation)
		[CLink]
		public static extern void DrawTextCodepoint(Font font, int32 codepoint, Vector2 position, float fontSize, Color tint);   // Draw one character (codepoint)

		// Text font info functions
		[CLink]
		public static extern int32 MeasureText(char8* text, int32 fontSize);                                      // Measure string width for default font
		[CLink]
		public static extern Vector2 MeasureTextEx(Font font, char8* text, float fontSize, float spacing);    // Measure string size for Font
		[CLink]
		public static extern int32 GetGlyphIndex(Font font, int32 codepoint);                                          // Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
		[CLink]
		public static extern GlyphInfo GetGlyphInfo(Font font, int32 codepoint);                                     // Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
		[CLink]
		public static extern Rectangle GetGlyphAtlasRec(Font font, int32 codepoint);                                 // Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found

		// Text codepoints management functions (unicode characters)
		[CLink]
		public static extern int32* LoadCodepoints(char8* text, int32* count);              // Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
		[CLink]
		public static extern void UnloadCodepoints(int32* codepoints);                         // Unload codepoints data from memory
		[CLink]
		public static extern int32 GetCodepointCount(char8* text);                        // Get total number of codepoints in a UTF-8 encoded string
		[CLink]
		public static extern int32 GetCodepoint(char8* text, int32* bytesProcessed);        // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
		[CLink]
		public static extern char8* CodepointToUTF8(int32 codepoint, int32* byteSize);      // Encode one codepoint into UTF-8 byte array (array length returned as parameter)
		[CLink]
		public static extern char8* TextCodepointsToUTF8(int32* codepoints, int32 length);        // Encode text as codepoints array into UTF-8 text string (WARNING: memory must be freed!)

		// Text strings management functions (no UTF-8 strings, only byte chars)
		// NOTE: Some strings allocate memory internally for returned strings, just be careful!
		[CLink]
		public static extern int32 TextCopy(char8* dst, char8* src);                                             // Copy one string to another, returns bytes copied
		[CLink]
		public static extern bool TextIsEqual(char8* text1, char8* text2);                               // Check if two text string are equal
		[CLink]
		public static extern uint32 TextLength(char8* text);                                            // Get text length, checks for '\0' ending
		[CLink]
		public static extern char8* TextFormat(char8* text, ...);                                        // Text formatting with variables (sprintf() style)
		[CLink]
		public static extern char8* TextSubtext(char8* text, int32 position, int32 length);                  // Get a piece of a text string
		[CLink]
		public static extern char8* TextReplace(char8* text, char8* replace, char8* by);                   // Replace text string (WARNING: memory must be freed!)
		[CLink]
		public static extern char8* TextInsert(char8* text, char8* insert, int32 position);                 // Insert text in a position (WARNING: memory must be freed!)
		[CLink]
		public static extern char8* TextJoin(char8** textList, int32 count, char8* delimiter);        // Join text strings with delimiter
		[CLink]
		public static extern char8* *TextSplit(char8* text, char8 delimiter, int32* count);                 // Split text into multiple strings
		[CLink]
		public static extern void TextAppend(char8* text, char8* append_, int32* position);                       // Append text at specific position and move cursor!
		[CLink]
		public static extern int32 TextFindIndex(char8* text, char8* find);                                // Find first text occurrence within a string
		[CLink]
		public static extern char8* TextToUpper(char8* text);                      // Get upper case version of provided string
		[CLink]
		public static extern char8* TextToLower(char8* text);                      // Get lower case version of provided string
		[CLink]
		public static extern char8* TextToPascal(char8* text);                     // Get Pascal case notation version of provided string
		[CLink]
		public static extern int32 TextToInteger(char8* text);                            // Get integer value from text (negative values not supported)

		//------------------------------------------------------------------------------------
		// Basic 3d Shapes Drawing Functions (Module: models)
		//------------------------------------------------------------------------------------

		// Basic geometric 3D shapes drawing functions
		[CLink]
		public static extern void DrawLine3D(Vector3 startPos, Vector3 endPos, Color color);                                    // Draw a line in 3D world space
		[CLink]
		public static extern void DrawPoint3D(Vector3 position, Color color);                                                   // Draw a point in 3D space, actually a small line
		[CLink]
		public static extern void DrawCircle3D(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color); // Draw a circle in 3D world space
		[CLink]
		public static extern void DrawTriangle3D(Vector3 v1, Vector3 v2, Vector3 v3, Color color);                              // Draw a color-filled triangle (vertex in counter-clockwise order!)
		[CLink]
		public static extern void DrawTriangleStrip3D(Vector3 *points, int pointCount, Color color);                           // Draw a triangle strip defined by points
		[CLink]
		public static extern void DrawCube(Vector3 position, float width, float height, float length, Color color);             // Draw cube
		[CLink]
		public static extern void DrawCubeV(Vector3 position, Vector3 size, Color color);                                       // Draw cube (Vector version)
		[CLink]
		public static extern void DrawCubeWires(Vector3 position, float width, float height, float length, Color color);        // Draw cube wires
		[CLink]
		public static extern void DrawCubeWiresV(Vector3 position, Vector3 size, Color color);                                  // Draw cube wires (Vector version)
		[CLink]
		public static extern void DrawCubeTexture(Texture2D texture, Vector3 position, float width, float height, float length, Color color); // Draw cube textured
		[CLink]
		public static extern void DrawCubeTextureRec(Texture2D texture, Rectangle source, Vector3 position, float width, float height, float length, Color color); // Draw cube with a region of a texture
		[CLink]
		public static extern void DrawSphere(Vector3 centerPos, float radius, Color color);                                     // Draw sphere
		[CLink]
		public static extern void DrawSphereEx(Vector3 centerPos, float radius, int32 rings, int32 slices, Color color);            // Draw sphere with extended parameters
		[CLink]
		public static extern void DrawSphereWires(Vector3 centerPos, float radius, int32 rings, int32 slices, Color color);         // Draw sphere wires
		[CLink]
		public static extern void DrawCylinder(Vector3 position, float radiusTop, float radiusBottom, float height, int32 slices, Color color); // Draw a cylinder/cone
		[CLink]
		public static extern void DrawCylinderEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int32 sides, Color color); // Draw a cylinder with base at startPos and top at endPos
		[CLink]
		public static extern void DrawCylinderWires(Vector3 position, float radiusTop, float radiusBottom, float height, int32 slices, Color color); // Draw a cylinder/cone wires
		[CLink]
		public static extern void DrawCylinderWiresEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int32 sides, Color color); // Draw a cylinder wires with base at startPos and top at endPos
		[CLink]
		public static extern void DrawPlane(Vector3 centerPos, Vector2 size, Color color);                                      // Draw a plane XZ
		[CLink]
		public static extern void DrawRay(Ray ray, Color color);                                                                // Draw a ray line
		[CLink]
		public static extern void DrawGrid(int32 slices, float spacing);

		//------------------------------------------------------------------------------------
		// Model 3d Loading and Drawing Functions (Module: models)
		//------------------------------------------------------------------------------------

		// Model management functions
		[CLink]
		public static extern Model LoadModel(char8* fileName);                                                // Load model from files (meshes and materials)
		[CLink]
		public static extern Model LoadModelFromMesh(Mesh mesh);                                                   // Load model from generated mesh (default material)
		[CLink]
		public static extern void UnloadModel(Model model);                                                        // Unload model (including meshes) from memory (RAM and/or VRAM)
		[CLink]
		public static extern void UnloadModelKeepMeshes(Model model);                                              // Unload model (but not meshes) from memory (RAM and/or VRAM)
		[CLink]
		public static extern BoundingBox GetModelBoundingBox(Model model);                                         // Compute model bounding box limits (considers all meshes)

		// Model drawing functions
		[CLink]
		public static extern void DrawModel(Model model, Vector3 position, float scale, Color tint);                           // Draw a model (with texture if set)
		[CLink]
		public static extern void DrawModelEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model with extended parameters
		[CLink]
		public static extern void DrawModelWires(Model model, Vector3 position, float scale, Color tint);                      // Draw a model wires (with texture if set)
		[CLink]
		public static extern void DrawModelWiresEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model wires (with texture if set) with extended parameters
		[CLink]
		public static extern void DrawBoundingBox(BoundingBox box_, Color color);                                               // Draw bounding box (wires)
		[CLink]
		public static extern void DrawBillboard(Camera camera, Texture2D texture, Vector3 position, float size, Color tint);   // Draw a billboard texture
		[CLink]
		public static extern void DrawBillboardRec(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Color tint); // Draw a billboard texture defined by source
		[CLink]
		public static extern void DrawBillboardPro(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector3 up, Vector2 size, Vector2 origin, float rotation, Color tint); // Draw a billboard texture defined by source and rotation

		// Mesh management functions
		[CLink]
		public static extern void UploadMesh(Mesh* mesh, bool dynamic);                                            // Upload mesh vertex data in GPU and provide VAO/VBO ids
		[CLink]
		public static extern void UpdateMeshBuffer(Mesh mesh, int32 index, void* data, int32 dataSize, int32 offset);    // Update mesh vertex data in GPU for a specific buffer index
		[CLink]
		public static extern void UnloadMesh(Mesh mesh);                                                           // Unload mesh data from CPU and GPU
		[CLink]
		public static extern void DrawMesh(Mesh mesh, Material material, Matrix transform);                        // Draw a 3d mesh with material and transform
		[CLink]
		public static extern void DrawMeshInstanced(Mesh mesh, Material material, Matrix* transforms, int32 instances); // Draw multiple mesh instances with material and different transforms
		[CLink]
		public static extern bool ExportMesh(Mesh mesh, char8* fileName);                                     // Export mesh data to file, returns true on success
		[CLink]
		public static extern BoundingBox GetMeshBoundingBox(Mesh mesh);                                            // Compute mesh bounding box limits
		[CLink]
		public static extern void GenMeshTangents(Mesh *mesh);                                                     // Compute mesh tangents
		[CLink]
		public static extern void GenMeshBinormals(Mesh *mesh);                                                    // Compute mesh binormals

		// Mesh generation functions
		[CLink]
		public static extern Mesh GenMeshPoly(int32 sides, float radius);                                            // Generate polygonal mesh
		[CLink]
		public static extern Mesh GenMeshPlane(float width, float length, int32 resX, int32 resZ);                     // Generate plane mesh (with subdivisions)
		[CLink]
		public static extern Mesh GenMeshCube(float width, float height, float length);                            // Generate cuboid mesh
		[CLink]
		public static extern Mesh GenMeshSphere(float radius, int32 rings, int32 slices);                              // Generate sphere mesh (standard sphere)
		[CLink]
		public static extern Mesh GenMeshHemiSphere(float radius, int32 rings, int32 slices);                          // Generate half-sphere mesh (no bottom cap)
		[CLink]
		public static extern Mesh GenMeshCylinder(float radius, float height, int32 slices);                         // Generate cylinder mesh
		[CLink]
		public static extern Mesh GenMeshCone(float radius, float height, int32 slices);                             // Generate cone/pyramid mesh
		[CLink]
		public static extern Mesh GenMeshTorus(float radius, float size, int32 radSeg, int32 sides);                   // Generate torus mesh
		[CLink]
		public static extern Mesh GenMeshKnot(float radius, float size, int32 radSeg, int32 sides);                    // Generate trefoil knot mesh
		[CLink]
		public static extern Mesh GenMeshHeightmap(Image heightmap, Vector3 size);                                 // Generate heightmap mesh from image data
		[CLink]
		public static extern Mesh GenMeshCubicmap(Image cubicmap, Vector3 cubeSize);                               // Generate cubes-based map mesh from image data

		// Material loading/unloading functions
		[CLink]
		public static extern Material* LoadMaterials(char8* fileName, int32* materialCount);                    // Load materials from model file
		[CLink]
		public static extern Material LoadMaterialDefault();                                                   // Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
		[CLink]
		public static extern void UnloadMaterial(Material material);                                               // Unload material from GPU memory (VRAM)
		[CLink]
		public static extern void SetMaterialTexture(Material* material, int32 mapType, Texture2D texture);          // Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
		[CLink]
		public static extern void SetModelMeshMaterial(Model* model, int32 meshId, int32 materialId);                  // Set material for a mesh

		// Model animations loading/unloading functions
		[CLink]
		public static extern ModelAnimation* LoadModelAnimations(char8* fileName, uint32* animCount);   // Load model animations from file
		[CLink]
		public static extern void UpdateModelAnimation(Model model, ModelAnimation anim, int32 frame);               // Update model animation pose
		[CLink]
		public static extern void UnloadModelAnimation(ModelAnimation anim);                                       // Unload animation data
		[CLink]
		public static extern void UnloadModelAnimations(ModelAnimation* animations, uint32 count);           // Unload animation array data
		[CLink]
		public static extern bool IsModelAnimationValid(Model model, ModelAnimation anim);                         // Check model animation skeleton match

		// Collision detection functions
		[CLink]
		public static extern bool CheckCollisionSpheres(Vector3 center1, float radius1, Vector3 center2, float radius2);       // Check collision between two spheres
		[CLink]
		public static extern bool CheckCollisionBoxes(BoundingBox box1, BoundingBox box2);                                     // Check collision between two bounding boxes
		[CLink]
		public static extern bool CheckCollisionBoxSphere(BoundingBox box_, Vector3 center, float radius);                      // Check collision between box and sphere
		[CLink]
		public static extern RayCollision GetRayCollisionSphere(Ray ray, Vector3 center, float radius);                        // Get collision info between ray and sphere
		[CLink]
		public static extern RayCollision GetRayCollisionBox(Ray ray, BoundingBox box_);                                        // Get collision info between ray and box
		[CLink]
		public static extern RayCollision GetRayCollisionModel(Ray ray, Model model);                                          // Get collision info between ray and model
		[CLink]
		public static extern RayCollision GetRayCollisionMesh(Ray ray, Mesh mesh, Matrix transform);                           // Get collision info between ray and mesh
		[CLink]
		public static extern RayCollision GetRayCollisionTriangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3);                // Get collision info between ray and triangle
		[CLink]
		public static extern RayCollision GetRayCollisionQuad(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4);        // Get collision info between ray and quad

		//------------------------------------------------------------------------------------
		// Audio Loading and Playing Functions (Module: audio)
		//------------------------------------------------------------------------------------

		// Audio device management functions
		[CLink]
		public static extern void InitAudioDevice();                                     // Initialize audio device and context
		[CLink]
		public static extern void CloseAudioDevice();                                    // Close the audio device and context
		[CLink]
		public static extern bool IsAudioDeviceReady();                                  // Check if audio device has been initialized successfully
		[CLink]
		public static extern void SetMasterVolume(float volume);                             // Set master volume (listener)

		// Wave/Sound loading/unloading functions
		[CLink]
		public static extern Wave LoadWave(char8* fileName);                            // Load wave data from file
		[CLink]
		public static extern Wave LoadWaveFromMemory(char8* fileType, uint8* fileData, int32 dataSize); // Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
		[CLink]
		public static extern Sound LoadSound(char8* fileName);                          // Load sound from file
		[CLink]
		public static extern Sound LoadSoundFromWave(Wave wave);                             // Load sound from wave data
		[CLink]
		public static extern void UpdateSound(Sound sound, void* data, int32 sampleCount); // Update sound buffer with new data
		[CLink]
		public static extern void UnloadWave(Wave wave);                                     // Unload wave data
		[CLink]
		public static extern void UnloadSound(Sound sound);                                  // Unload sound
		[CLink]
		public static extern bool ExportWave(Wave wave, char8* fileName);               // Export wave data to file, returns true on success
		[CLink]
		public static extern bool ExportWaveAsCode(Wave wave, char8* fileName);         // Export wave sample data to code (.h), returns true on success

		// Wave/Sound management functions
		[CLink]
		public static extern void PlaySound(Sound sound);                                    // Play a sound
		[CLink]
		public static extern void StopSound(Sound sound);                                    // Stop playing a sound
		[CLink]
		public static extern void PauseSound(Sound sound);                                   // Pause a sound
		[CLink]
		public static extern void ResumeSound(Sound sound);                                  // Resume a paused sound
		[CLink]
		public static extern void PlaySoundMulti(Sound sound);                               // Play a sound (using multichannel buffer pool)
		[CLink]
		public static extern void StopSoundMulti();                                      // Stop any sound playing (using multichannel buffer pool)
		[CLink]
		public static extern int32 GetSoundsPlaying();                                     // Get number of sounds playing in the multichannel
		[CLink]
		public static extern bool IsSoundPlaying(Sound sound);                               // Check if a sound is currently playing
		[CLink]
		public static extern void SetSoundVolume(Sound sound, float volume);                 // Set volume for a sound (1.0 is max level)
		[CLink]
		public static extern void SetSoundPitch(Sound sound, float pitch);                   // Set pitch for a sound (1.0 is base level)
		[CLink]
		public static extern void WaveFormat(Wave *wave, int32 sampleRate, int32 sampleSize, int32 channels);  // Convert wave data to desired format
		[CLink]
		public static extern Wave WaveCopy(Wave wave);                                       // Copy a wave to a new wave
		[CLink]
		public static extern void WaveCrop(Wave *wave, int32 initSample, int32 finalSample);     // Crop a wave to defined samples range
		[CLink]
		public static extern float* LoadWaveSamples(Wave wave);                              // Load samples data from wave as a floats array
		[CLink]
		public static extern void UnloadWaveSamples(float* samples);                         // Unload samples data loaded with LoadWaveSamples()

		// Music management functions
		[CLink]
		public static extern Music LoadMusicStream(char8* fileName);                    // Load music stream from file
		[CLink]
		public static extern Music LoadMusicStreamFromMemory(char8* fileType, uint8* data, int32 dataSize); // Load music stream from data
		[CLink]
		public static extern void UnloadMusicStream(Music music);                            // Unload music stream
		[CLink]
		public static extern void PlayMusicStream(Music music);                              // Start music playing
		[CLink]
		public static extern bool IsMusicStreamPlaying(Music music);                         // Check if music is playing
		[CLink]
		public static extern void UpdateMusicStream(Music music);                            // Updates buffers for music streaming
		[CLink]
		public static extern void StopMusicStream(Music music);                              // Stop music playing
		[CLink]
		public static extern void PauseMusicStream(Music music);                             // Pause music playing
		[CLink]
		public static extern void ResumeMusicStream(Music music);                            // Resume playing paused music
		[CLink]
		public static extern void SeekMusicStream(Music music, float position);              // Seek music to a position (in seconds)
		[CLink]
		public static extern void SetMusicVolume(Music music, float volume);                 // Set volume for music (1.0 is max level)
		[CLink]
		public static extern void SetMusicPitch(Music music, float pitch);                   // Set pitch for a music (1.0 is base level)
		[CLink]
		public static extern float GetMusicTimeLength(Music music);                          // Get music time length (in seconds)
		[CLink]
		public static extern float GetMusicTimePlayed(Music music);                          // Get current music time played (in seconds)

		// AudioStream management functions
		[CLink]
		public static extern AudioStream LoadAudioStream(uint32 sampleRate, uint32 sampleSize, uint32 channels); // Load audio stream (to stream raw audio pcm data)
		[CLink]
		public static extern void UnloadAudioStream(AudioStream stream);                      // Unload audio stream and free memory
		[CLink]
		public static extern void UpdateAudioStream(AudioStream stream, void* data, int32 frameCount); // Update audio stream buffers with data
		[CLink]
		public static extern bool IsAudioStreamProcessed(AudioStream stream);                // Check if any audio stream buffers requires refill
		[CLink]
		public static extern void PlayAudioStream(AudioStream stream);                       // Play audio stream
		[CLink]
		public static extern void PauseAudioStream(AudioStream stream);                      // Pause audio stream
		[CLink]
		public static extern void ResumeAudioStream(AudioStream stream);                     // Resume audio stream
		[CLink]
		public static extern bool IsAudioStreamPlaying(AudioStream stream);                  // Check if audio stream is playing
		[CLink]
		public static extern void StopAudioStream(AudioStream stream);                       // Stop audio stream
		[CLink]
		public static extern void SetAudioStreamVolume(AudioStream stream, float volume);    // Set volume for audio stream (1.0 is max level)
		[CLink]
		public static extern void SetAudioStreamPitch(AudioStream stream, float pitch);      // Set pitch for audio stream (1.0 is base level)
		[CLink]
		public static extern void SetAudioStreamBufferSizeDefault(int32 size);                 // Default size for new audio streams
	}

	// Raymath stuff

	// NOTE: Helper types to be used instead of array return types for *ToFloat functions
	[CRepr]
	struct float3
	{
		public float[3] v;
	}

	[CRepr]
	struct float16
	{
		public float[16] v;
	}

	static
	{
		// Normalize input value within input range
		public static float Normalize(float value, float start, float end)
		{
			float result = (value - start)/(end - start);

			return result;
		}

		// Remap input value within input range to output range
		public static float Remap(float value, float inputStart, float inputEnd, float outputStart, float outputEnd)
		{
			float result =(value - inputStart)/(inputEnd - inputStart)*(outputEnd - outputStart) + outputStart;

			return result;
		}
	}
}