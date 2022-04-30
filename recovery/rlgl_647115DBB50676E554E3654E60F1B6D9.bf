using System;

namespace Raylib.rl
{
	static
	{
		public const char8* VERSION = "4.0";

		public const int32 DEFAULT_BATCH_BUFFERS = 1;
		public const int32 DEFAULT_BATCH_DRAWCALLS = 256;
		public const int32 DEFAULT_BATCH_MAX_TEXTURE_UNITS = 4;

		public const int32 MAX_MATRIX_STACK_SIZE = 32;
		public const int32 MAX_MATRIX_LOCATIONS = 32;

		public const double CULL_DISTANCE_NEAR = 0.01;
		public const double CULL_DISTANCE_FAR = 1000.0;

		public const int32 TEXTURE_WRAP_S = 0x2802;
		public const int32 TEXTURE_WRAP_T = 0x2803;
		public const int32 TEXTURE_MAG_FILTER = 0x2800;
		public const int32 TEXTURE_MIN_FILTER = 0x2801;

		public const int32 TEXTURE_FILTER_NEAREST = 0x2600;
		public const int32 TEXTURE_FILTER_LINEAR= 0x2601;
		public const int32 TEXTURE_FILTER_MIP_NEAREST = 0x2700;
		public const int32 TEXTURE_FILTER_NEAREST_MIP_LINEAR = 0x2702;
		public const int32 TEXTURE_FILTER_LINEAR_MIP_NEAREST = 0x2701;
		public const int32 TEXTURE_FILTER_MIP_LINEAR = 0x2703;
		public const int32 TEXTURE_FILTER_ANISOTROPIC = 0x3000;

		public const int32 TEXTURE_WRAP_REPEAT = 0x2901;
		public const int32 TEXTURE_WRAP_CLAMP = 0x812F;
		public const int32 TEXTURE_WRAP_MIRROR_REPEAT = 0x8370;
		public const int32 TEXTURE_WRAP_MIRROR_CLAMP = 0x8742;

		public const int32 MODELVIEW = 0x1700;
		public const int32 PROJECTION = 0x1701;
		public const int32 TEXTURE = 0x1702;

		public const int32 LINES = 0x0001;
		public const int32 TRIANGLES = 0x0004;
		public const int32 QUADS = 0x0007;

		public const int32 UNSIGNED_BYTE = 0x1401;
		public const int32 FLOAT = 0x1406;

		public const int32 STREAM_DRAW = 0x88E0;
		public const int32 STREAM_READ = 0x88E1;
		public const int32 STREAM_COPY = 0x88E2;
		public const int32 STATIC_DRAW = 0x88E4;
		public const int32 STATIC_READ = 0x88E5;
		public const int32 STATIC_COPY = 0x88E6;
		public const int32 DYNAMIC_DRAW = 0x88E8;
		public const int32 DYNAMIC_READ = 0x88E9;
		public const int32 DYNAMIC_COPY = 0x88EA;

		public const int32 FRAGMENT_SHADER = 0x8B30;
		public const int32 VERTEX_SHADER = 0x8B31;
		public const int32 COMPUTE_SHADER = 0x91B9;
	}

	enum Version : int32
	{
		OPENGL_11 = 1,
		OPENGL_21,
		OPENGL_33,
		OPENGL_43,
		OPENGL_ES_20
	}

	enum FramebufferAttachType : int32
	{
		COLOR_CHANNEL0 = 0,
		COLOR_CHANNEL1,
		COLOR_CHANNEL2,
		COLOR_CHANNEL3,
		COLOR_CHANNEL4,
		COLOR_CHANNEL5,
		COLOR_CHANNEL6,
		COLOR_CHANNEL7,
		DEPTH = 100,
		STENCIL = 200,
	}

	enum FramebufferAttachTextureType : int32
	{
		CUBEMAP_POSITIVE_X = 0,
		CUBEMAP_NEGATIVE_X,
		CUBEMAP_POSITIVE_Y,
		CUBEMAP_NEGATIVE_Y,
		CUBEMAP_POSITIVE_Z,
		CUBEMAP_NEGATIVE_Z,
		TEXTURE2D = 100,
		RENDERBUFFER = 200,
	}

	// Dynamic vertex buffers (position + texcoords + colors + indices arrays)
	/*[CRepr]
	struct VertexBuffer {
	    int32 elementCount;           // Number of elements in the buffer (QUADS)

	    float* vertices;            // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
	    float* texcoords;           // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
	    uint8* colors;      // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
		VertexBufferIndexType* indices;
	    unsigned int vaoId;         // OpenGL Vertex Array Object id
	    unsigned int vboId[4];      // OpenGL Vertex Buffer Objects id (4 types of vertex data)
	} rlVertexBuffer;*/
}