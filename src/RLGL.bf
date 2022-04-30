using System;

namespace Raylib.rl
{
	static
	{
		public const char8* VERSION = "4.0";

		public const bool GRAPHICS_API_OPENGL_11 = false;
		public const bool GRAPHICS_API_OPENGL21 = false;
		public const bool GRAPHICS_API_OPENGL33 = true;
		public const bool GRAPHICS_API_OPENGL43 = false;
		public const bool GRAPHICS_API_OPENGL_ES2 = false;

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
	[CRepr]
	struct VertexBuffer
	{
	    public int32 elementCount;           // Number of elements in the buffer (QUADS)

	    public float* vertices;            // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
	    public float* texcoords;           // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
	    public uint8* colors;      // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
#if GRAPHICS_API_OPENGL_11 || GRAPHICS_API_OPENGL_33
		public uint32* indices;
#endif
#if GRAPHICS_API_OPENGL_ES2
		public uint16* indices;
#endif
	    public uint32 vaoId;         // OpenGL Vertex Array Object id
	    public uint32[4] vboId;      // OpenGL Vertex Buffer Objects id (4 types of vertex data)
	}

	// Draw call type
	// NOTE: Only texture changes register a new draw, other state-change-related elements are not
	// used at this moment (vaoId, shaderId, matrices), raylib just forces a batch draw call if any
	// of those state-change happens (this is done in core module)
	[CRepr]
	struct DrawCall
	{
	    public int32 mode;                   // Drawing mode: LINES, TRIANGLES, QUADS
	    public int32 vertexCount;            // Number of vertex of the draw
	    public int32 vertexAlignment;        // Number of vertex required for index alignment (LINES, TRIANGLES)
	    //public uint32 vaoId;       // Vertex array id to be used on the draw -> Using RLGL.currentBatch->vertexBuffer.vaoId
	    //public uint32 shaderId;    // Shader id to be used on the draw -> Using RLGL.currentShaderId
	    public uint32 textureId;     // Texture id to be used on the draw -> Use to create new draw call if changes

	    //public Matrix projection;      // Projection matrix for this draw -> Using RLGL.projection by default
	    //public Matrix modelview;       // Modelview matrix for this draw -> Using RLGL.modelview by default
	}

	// rlRenderBatch type
	[CRepr]
	struct RenderBatch
	{
	    public int32 bufferCount;            // Number of vertex buffers (multi-buffering support)
	    public int32 currentBuffer;          // Current buffer tracking in case of multi-buffering
	    public VertexBuffer* vertexBuffer; // Dynamic buffer(s) for vertex data

	    public DrawCall* draws;          // Draw calls array, depends on textureId
	    public int32 drawCounter;            // Draw calls counter
	    public float currentDepth;         // Current depth value for next draw
	}

	// Trace log level
	// NOTE: Organized by priority level
	enum TraceLogLevel : int32
	{
	    ALL = 0,            // Display all logs
	    TRACE,              // Trace logging, intended for internal use only
	    DEBUG,              // Debug logging, used for internal debugging, it should be disabled on release builds
	    INFO,               // Info logging, used for program execution info
	    WARNING,            // Warning logging, used on recoverable failures
	    ERROR,              // Error logging, used on unrecoverable failures
	    FATAL,              // Fatal logging, used to abort program: exit(EXIT_FAILURE)
	    NONE                // Disable logging
	}

	// Texture formats (support depends on OpenGL version)
	enum PixelFormat : int32
	{
	    UNCOMPRESSED_GRAYSCALE = 1,     // 8 bit per pixel (no alpha)
	    UNCOMPRESSED_GRAY_ALPHA,        // 8*2 bpp (2 channels)
	    UNCOMPRESSED_R5G6B5,            // 16 bpp
	    UNCOMPRESSED_R8G8B8,            // 24 bpp
	    UNCOMPRESSED_R5G5B5A1,          // 16 bpp (1 bit alpha)
	    UNCOMPRESSED_R4G4B4A4,          // 16 bpp (4 bit alpha)
	    UNCOMPRESSED_R8G8B8A8,          // 32 bpp
	    UNCOMPRESSED_R32,               // 32 bpp (1 channel - float)
	    UNCOMPRESSED_R32G32B32,         // 32*3 bpp (3 channels - float)
	    UNCOMPRESSED_R32G32B32A32,      // 32*4 bpp (4 channels - float)
	    COMPRESSED_DXT1_RGB,            // 4 bpp (no alpha)
	    COMPRESSED_DXT1_RGBA,           // 4 bpp (1 bit alpha)
	    COMPRESSED_DXT3_RGBA,           // 8 bpp
	    COMPRESSED_DXT5_RGBA,           // 8 bpp
	    COMPRESSED_ETC1_RGB,            // 4 bpp
	    COMPRESSED_ETC2_RGB,            // 4 bpp
	    COMPRESSED_ETC2_EAC_RGBA,       // 8 bpp
	    COMPRESSED_PVRT_RGB,            // 4 bpp
	    COMPRESSED_PVRT_RGBA,           // 4 bpp
	    COMPRESSED_ASTC_4x4_RGBA,       // 8 bpp
	    COMPRESSED_ASTC_8x8_RGBA        // 2 bpp
	}

	// Texture parameters: filter mode
	// NOTE 1: Filtering considers mipmaps if available in the texture
	// NOTE 2: Filter is accordingly set for minification and magnification
	enum TextureFilter : int32
	{
	    POINT = 0,               // No filter, just pixel aproximation
	    BILINEAR,                // Linear filtering
	    TRILINEAR,               // Trilinear filtering (linear with mipmaps)
	    ANISOTROPIC_4X,          // Anisotropic filtering 4x
	    ANISOTROPIC_8X,          // Anisotropic filtering 8x
	    ANISOTROPIC_16X,         // Anisotropic filtering 16x
	}

	// Color blending modes (pre-defined)
	enum BlendMode : int32
	{
	    ALPHA = 0,                // Blend textures considering alpha (default)
	    ADDITIVE,                 // Blend textures adding colors
	    MULTIPLIED,               // Blend textures multiplying colors
	    ADD_COLORS,               // Blend textures adding colors (alternative)
	    SUBTRACT_COLORS,          // Blend textures subtracting colors (alternative)
	    CUSTOM                    // Belnd textures using custom src/dst factors (use SetBlendModeCustom())
	}

	// Shader location point type
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

	// Shader uniform data type
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

	// Shader attribute data types
	enum ShaderAttributeDataType {
	    FLOAT = 0,        // Shader attribute type: float
	    VEC2,             // Shader attribute type: vec2 (2 float)
	    VEC3,             // Shader attribute type: vec3 (3 float)
	    VEC4              // Shader attribute type: vec4 (4 float)
	}

	static
	{
		//------------------------------------------------------------------------------------
		// Functions Declaration - Matrix operations
		//------------------------------------------------------------------------------------
		[LinkName("rlMatrixMode")]
		public static extern void MatrixMode(int32 mode);                    // Choose the current matrix to be transformed
		[LinkName("rlPushMatrix")]
		public static extern void PushMatrix();                        // Push the current matrix to stack
		[LinkName("rlPopMatrix")]
		public static extern void PopMatrix();                         // Pop lattest inserted matrix from stack
		[LinkName("rlLoadIdentity")]
		public static extern void LoadIdentity();                      // Reset current matrix to identity matrix
		[LinkName("rlTranslatef")]
		public static extern void Translatef(float x, float y, float z);   // Multiply the current matrix by a translation matrix
		[LinkName("rlRotatef")]
		public static extern void Rotatef(float angle, float x, float y, float z);  // Multiply the current matrix by a rotation matrix
		[LinkName("rlScalef(")]
		public static extern void Scalef(float x, float y, float z);       // Multiply the current matrix by a scaling matrix
		[LinkName("rlMultMatrixf")]
		public static extern void MultMatrixf(float* matf);                // Multiply the current matrix by another matrix
		[LinkName("rlFrustum")]
		public static extern void Frustum(double left, double right, double bottom, double top, double znear, double zfar);
		[LinkName("rlOrtho")]
		public static extern void Ortho(double left, double right, double bottom, double top, double znear, double zfar);
		[LinkName("rlViewport")]
		public static extern void Viewport(int32 x, int32 y, int32 width, int32 height); // Set the viewport area

		//------------------------------------------------------------------------------------
		// Functions Declaration - Vertex level operations
		//------------------------------------------------------------------------------------
		[LinkName("rlBegin")]
		public static extern void Begin(int32 mode);                         // Initialize drawing mode (how to organize vertex)
		[LinkName("rlEnd")]
		public static extern void End();                               // Finish vertex providing
		[LinkName("rlVertex2i")]
		public static extern void Vertex2i(int32 x, int32 y);                  // Define one vertex (position) - 2 int
		[LinkName("rlVertex2f")]
		public static extern void Vertex2f(float x, float y);              // Define one vertex (position) - 2 float
		[LinkName("rlVertex3f")]
		public static extern void Vertex3f(float x, float y, float z);     // Define one vertex (position) - 3 float
		[LinkName("rlTexCoord2f")]
		public static extern void TexCoord2f(float x, float y);            // Define one vertex (texture coordinate) - 2 float
		[LinkName("rlNormal3f")]
		public static extern void Normal3f(float x, float y, float z);     // Define one vertex (normal) - 3 float
		[LinkName("rlColor4ub")]
		public static extern void Color4ub(uint8 r, uint8 g, uint8 b, uint8 a);  // Define one vertex (color) - 4 byte
		[LinkName("rlColor3f")]
		public static extern void Color3f(float x, float y, float z);          // Define one vertex (color) - 3 float
		[LinkName("rlColor4f")]
		public static extern void Color4f(float x, float y, float z, float w); // Define one vertex (color) - 4 float

		//------------------------------------------------------------------------------------
		// Functions Declaration - OpenGL style functions (common to 1.1, 3.3+, ES2)
		// NOTE: This functions are used to completely abstract raylib code from OpenGL layer,
		// some of them are direct wrappers over OpenGL calls, some others are custom
		//------------------------------------------------------------------------------------

		// Vertex buffers state
		[LinkName("rlEnableVertexArray")]
		public static extern bool EnableVertexArray(uint32 vaoId);     // Enable vertex array (VAO, if supported)
		[LinkName("rlDisableVertexArray")]
		public static extern void DisableVertexArray();                  // Disable vertex array (VAO, if supported)
		[LinkName("rlEnableVertexBuffer")]
		public static extern void EnableVertexBuffer(uint32 id);       // Enable vertex buffer (VBO)
		[LinkName("rlDisableVertexBuffer")]
		public static extern void DisableVertexBuffer();                 // Disable vertex buffer (VBO)
		[LinkName("rlEnableVertexBufferElement")]
		public static extern void EnableVertexBufferElement(uint32 id);// Enable vertex buffer element (VBO element)
		[LinkName("rlDisableVertexBufferElement")]
		public static extern void DisableVertexBufferElement();          // Disable vertex buffer element (VBO element)
		[LinkName("rlEnableVertexAttribute")]
		public static extern void EnableVertexAttribute(uint32 index); // Enable vertex attribute index
		[LinkName("rlDisableVertexAttribute")]
		public static extern void DisableVertexAttribute(uint32 index);// Disable vertex attribute index
#if GRAPHICS_API_OPENGL_11
		[LinkName("")]
		public static extern void rlEnableStatePointer(int vertexAttribType, void *buffer);    // Enable attribute state pointer
		[LinkName("")]
		public static extern void rlDisableStatePointer(int vertexAttribType);                 // Disable attribute state pointer
#endif

		// Textures state
		[LinkName("rlActiveTextureSlot")]
		public static extern void ActiveTextureSlot(int32 slot);               // Select and active a texture slot
		[LinkName("rlEnableTexture")]
		public static extern void EnableTexture(uint32 id);            // Enable texture
		[LinkName("rlDisableTexture")]
		public static extern void DisableTexture();                      // Disable texture
		[LinkName("rlEnableTextureCubemap")]
		public static extern void EnableTextureCubemap(uint32 id);     // Enable texture cubemap
		[LinkName("rlDisableTextureCubemap")]
		public static extern void DisableTextureCubemap();               // Disable texture cubemap
		[LinkName("rlTextureParameters")]
		public static extern void TextureParameters(uint32 id, int32 param, int32 value); // Set texture parameters (filter, wrap)

		// Shader state
		[LinkName("rlEnableShader")]
		public static extern void EnableShader(uint32 id);             // Enable shader program
		[LinkName("rlDisableShader")]
		public static extern void DisableShader();                       // Disable shader program

		// Framebuffer state
		[LinkName("rlEnableFramebuffer")]
		public static extern void EnableFramebuffer(uint32 id);        // Enable render texture (fbo)
		[LinkName("rlDisableFramebuffer")]
		public static extern void DisableFramebuffer();                  // Disable render texture (fbo), return to default framebuffer
		[LinkName("rlActiveDrawBuffers")]
		public static extern void ActiveDrawBuffers(int32 count);              // Activate multiple draw color buffers

		// General render state
		[LinkName("rlEnableColorBlend")]
		public static extern void EnableColorBlend();                     // Enable color blending
		[LinkName("rlDisableColorBlend")]
		public static extern void DisableColorBlend();                   // Disable color blending
		[LinkName("rlEnableDepthTest")]
		public static extern void EnableDepthTest();                     // Enable depth test
		[LinkName("rlDisableDepthTest")]
		public static extern void DisableDepthTest();                    // Disable depth test
		[LinkName("rlEnableDepthMask")]
		public static extern void EnableDepthMask();                     // Enable depth write
		[LinkName("rlDisableDepthMask")]
		public static extern void DisableDepthMask();                    // Disable depth write
		[LinkName("rlEnableBackfaceCulling")]
		public static extern void EnableBackfaceCulling();               // Enable backface culling
		[LinkName("rlDisableBackfaceCulling")]
		public static extern void DisableBackfaceCulling();              // Disable backface culling
		[LinkName("rlEnableScissorTest")]
		public static extern void EnableScissorTest();                   // Enable scissor test
		[LinkName("rlDisableScissorTest")]
		public static extern void DisableScissorTest();                  // Disable scissor test
		[LinkName("rlScissor")]
		public static extern void Scissor(int32 x, int32 y, int32 width, int32 height); // Scissor test
		[LinkName("rlEnableWireMode")]
		public static extern void EnableWireMode();                      // Enable wire mode
		[LinkName("rlDisableWireMode")]
		public static extern void DisableWireMode();                     // Disable wire mode
		[LinkName("rlSetLineWidth")]
		public static extern void SetLineWidth(float width);                 // Set the line drawing width
		[LinkName("rlGetLineWidth")]
		public static extern float GetLineWidth();                       // Get the line drawing width
		[LinkName("rlEnableSmoothLines")]
		public static extern void EnableSmoothLines();                   // Enable line aliasing
		[LinkName("rlDisableSmoothLines")]
		public static extern void DisableSmoothLines();                  // Disable line aliasing
		[LinkName("rlEnableStereoRender")]
		public static extern void EnableStereoRender();                  // Enable stereo rendering
		[LinkName("rlDisableStereoRender")]
		public static extern void DisableStereoRender();                 // Disable stereo rendering
		[LinkName("rlIsStereoRenderEnabled")]
		public static extern bool IsStereoRenderEnabled();               // Check if stereo render is enabled

		[LinkName("rlClearColor")]
		public static extern void ClearColor(uint8 r, uint8 g, uint8 b, uint8 a); // Clear color buffer with color
		[LinkName("rlClearScreenBuffers")]
		public static extern void ClearScreenBuffers();                  // Clear used screen buffers (color and depth)
		[LinkName("rlCheckErrors")]
		public static extern void CheckErrors();                         // Check and log OpenGL error codes
		[LinkName("rlSetBlendMode")]
		public static extern void SetBlendMode(int32 mode);                    // Set blending mode
		[LinkName("rlSetBlendFactors")]
		public static extern void SetBlendFactors(int32 glSrcFactor, int32 glDstFactor, int32 glEquation); // Set blending mode factor and equation (using OpenGL factors)

		//------------------------------------------------------------------------------------
		// Functions Declaration - rlgl functionality
		//------------------------------------------------------------------------------------
		// rlgl initialization functions
		[LinkName("rlglInit")]
		public static extern void glInit(int32 width, int32 height);           // Initialize rlgl (buffers, shaders, textures, states)
		[LinkName("rlglClose")]
		public static extern void glClose();                           // De-inititialize rlgl (buffers, shaders, textures)
		[LinkName("rlLoadExtensions")]
		public static extern void LoadExtensions(void* loader);            // Load OpenGL extensions (loader function required)
		[LinkName("rlGetVersion")]
		public static extern int32 GetVersion();                         // Get current OpenGL version
		[LinkName("rlGetFramebufferWidth")]
		public static extern int32 GetFramebufferWidth();                // Get default framebuffer width
		[LinkName("rlGetFramebufferHeight")]
		public static extern int32 GetFramebufferHeight();               // Get default framebuffer height

		[LinkName("rlGetTextureIdDefault")]
		public static extern uint32 GetTextureIdDefault();       // Get default texture id
		[LinkName("rlGetShaderIdDefault")]
		public static extern uint32 GetShaderIdDefault();        // Get default shader id
		[LinkName("rlGetShaderLocsDefault")]
		public static extern uint32* GetShaderLocsDefault();              // Get default shader locations

		// Render batch management
		// NOTE: rlgl provides a default render batch to behave like OpenGL 1.1 immediate mode
		// but this render batch API is exposed in case of custom batches are required
		[LinkName("rlLoadRenderBatch")]
		public static extern RenderBatch LoadRenderBatch(int32 numBuffers, int32 bufferElements);  // Load a render batch system
		[LinkName("rlUnloadRenderBatch")]
		public static extern void UnloadRenderBatch(RenderBatch batch);                        // Unload render batch system
		[LinkName("rlDrawRenderBatch")]
		public static extern void DrawRenderBatch(RenderBatch* batch);                         // Draw render batch data (Update->Draw->Reset)
		[LinkName("rlSetRenderBatchActive")]
		public static extern void SetRenderBatchActive(RenderBatch* batch);                    // Set the active render batch for rlgl (NULL for default internal)
		[LinkName("rlDrawRenderBatchActive")]
		public static extern void DrawRenderBatchActive();                                   // Update and draw internal render batch
		[LinkName("rlCheckRenderBatchLimit")]
		public static extern bool CheckRenderBatchLimit(int32 vCount);                             // Check internal buffer overflow for a given number of vertex
		[LinkName("rlSetTexture")]
		public static extern void SetTexture(uint32 id);           // Set current texture for render batch and check buffers limits

		//------------------------------------------------------------------------------------------------------------------------

		// Vertex buffers management
		[LinkName("rlLoadVertexArray")]
		public static extern uint32 LoadVertexArray();                               // Load vertex array (vao) if supported
		[LinkName("rlLoadVertexBuffer")]
		public static extern uint32 LoadVertexBuffer(void* buffer, int32 size, bool dynamic);            // Load a vertex buffer attribute
		[LinkName("rlLoadVertexBufferElement")]
		public static extern uint32 LoadVertexBufferElement(void *buffer, int32 size, bool dynamic);     // Load a new attributes element buffer
		[LinkName("rlUpdateVertexBuffer")]
		public static extern void UpdateVertexBuffer(uint32 bufferId, void* data, int32 dataSize, int32 offset);    // Update GPU buffer with new data
		[LinkName("rlUnloadVertexArray")]
		public static extern void UnloadVertexArray(uint32 vaoId);
		[LinkName("rlUnloadVertexBuffer")]
		public static extern void UnloadVertexBuffer(uint32 vboId);
		[LinkName("rlSetVertexAttribute")]
		public static extern void SetVertexAttribute(uint32 index, int32 compSize, int32 type, bool normalized, int32 stride, void* pointer);
		[LinkName("rlSetVertexAttributeDivisor")]
		public static extern void SetVertexAttributeDivisor(uint32 index, int32 divisor);
		[LinkName("rlSetVertexAttributeDefault")]
		public static extern void SetVertexAttributeDefault(int32 locIndex, void* value, int32 attribType, int32 count); // Set vertex attribute default value
		[LinkName("rlDrawVertexArray")]
		public static extern void DrawVertexArray(int32 offset, int32 count);
		[LinkName("rlDrawVertexArrayElements")]
		public static extern void DrawVertexArrayElements(int32 offset, int32 count, void* buffer);
		[LinkName("rlDrawVertexArrayInstanced")]
		public static extern void DrawVertexArrayInstanced(int32 offset, int32 count, int32 instances);
		[LinkName("rlDrawVertexArrayElementsInstanced")]
		public static extern void DrawVertexArrayElementsInstanced(int32 offset, int32 count, void* buffer, int32 instances);

		// Textures management
		[LinkName("rlLoadTexture")]
		public static extern uint32 LoadTexture(void* data, int32 width, int32 height, int32 format, int32 mipmapCount); // Load texture in GPU
		[LinkName("rlLoadTextureDepth")]
		public static extern uint32 LoadTextureDepth(int32 width, int32 height, bool useRenderBuffer);               // Load depth texture/renderbuffer (to be attached to fbo)
		[LinkName("rlLoadTextureCubemap")]
		public static extern uint32 LoadTextureCubemap(void* data, int32 size, int32 format);                        // Load texture cubemap
		[LinkName("rlUpdateTexture")]
		public static extern void UpdateTexture(uint32 id, int32 offsetX, int32 offsetY, int32 width, int32 height, int32 format, void* data);  // Update GPU texture with new data
		[LinkName("rlGetGlTextureFormats")]
		public static extern void GetGlTextureFormats(int32 format, int32* glInternalFormat, int32* glFormat, int32* glType);  // Get OpenGL internal formats
		[LinkName("rlGetPixelFormatName")]
		public static extern char8* GetPixelFormatName(uint32 format);              // Get name string for pixel format
		[LinkName("rlUnloadTexture")]
		public static extern void UnloadTexture(uint32 id);                              // Unload texture from GPU memory
		[LinkName("rlGenTextureMipmaps")]
		public static extern void GenTextureMipmaps(uint32 id, int32 width, int32 height, int32 format, int32* mipmaps); // Generate mipmap data for selected texture
		[LinkName("rlReadTexturePixels")]
		public static extern void* ReadTexturePixels(uint32 id, int32 width, int32 height, int32 format);              // Read texture pixel data
		[LinkName("rlReadScreenPixels")]
		public static extern uint8* ReadScreenPixels(int32 width, int32 height);           // Read screen pixel data (color buffer)

		// Framebuffer management (fbo)
		[LinkName("rlLoadFramebuffer")]
		public static extern uint32 LoadFramebuffer(int32 width, int32 height);              // Load an empty framebuffer
		[LinkName("rlFramebufferAttach")]
		public static extern void FramebufferAttach(uint32 fboId, uint32 texId, int32 attachType, int32 texType, int32 mipLevel);  // Attach texture/renderbuffer to a framebuffer
		[LinkName("rlFramebufferComplete")]
		public static extern bool FramebufferComplete(uint32 id);                        // Verify framebuffer is complete
		[LinkName("rlUnloadFramebuffer")]
		public static extern void UnloadFramebuffer(uint32 id);                          // Delete framebuffer from GPU

		// Shaders management
		[LinkName("rlLoadShaderCode")]
		public static extern uint32 LoadShaderCode(char8* vsCode, char8* fsCode);    // Load shader from code strings
		[LinkName("rlCompileShader")]
		public static extern uint32 CompileShader(char8* shaderCode, int32 type);           // Compile custom shader and return shader id (type: RL_VERTEX_SHADER, RL_FRAGMENT_SHADER, RL_COMPUTE_SHADER)
		[LinkName("rlLoadShaderProgram")]
		public static extern uint32 LoadShaderProgram(uint32 vShaderId, uint32 fShaderId); // Load custom shader program
		[LinkName("rlUnloadShaderProgram")]
		public static extern void UnloadShaderProgram(uint32 id);                              // Unload shader program
		[LinkName("rlGetLocationUniform")]
		public static extern int32 GetLocationUniform(uint32 shaderId, uint32 uniformName); // Get shader location uniform
		[LinkName("rlGetLocationAttrib")]
		public static extern int32 GetLocationAttrib(uint32 shaderId, char8* attribName);   // Get shader location attribute
		[LinkName("rlSetUniform")]
		public static extern void SetUniform(int32 locIndex, void* value, int32 uniformType, int32 count);   // Set shader value uniform
		[LinkName("rlSetUniformMatrix")]
		public static extern void SetUniformMatrix(int32 locIndex, Matrix mat);                        // Set shader value matrix
		[LinkName("rlSetUniformSampler")]
		public static extern void SetUniformSampler(int32 locIndex, uint32 textureId);           // Set shader value sampler
		[LinkName("rlSetShader")]
		public static extern void SetShader(uint32 id, int32* locs);                             // Set shader currently active (id and locations)

		// Compute shader management
		[LinkName("rlLoadComputeShaderProgram")]
		public static extern uint32 LoadComputeShaderProgram(uint32 shaderId);           // Load compute shader program
		[LinkName("rlComputeShaderDispatch")]
		public static extern void ComputeShaderDispatch(uint32 groupX, uint32 groupY, uint32 groupZ);  // Dispatch compute shader (equivalent to *draw* for graphics pilepine)

		// Shader buffer storage object management (ssbo)
		[LinkName("rlLoadShaderBuffer")]
		public static extern uint32 LoadShaderBuffer(uint64 size, void* data, int32 usageHint);    // Load shader storage buffer object (SSBO)
		[LinkName("rlUnloadShaderBuffer")]
		public static extern void UnloadShaderBuffer(uint32 ssboId);                           // Unload shader storage buffer object (SSBO)
		[LinkName("rlUpdateShaderBufferElements")]
		public static extern void UpdateShaderBufferElements(uint32 id, void* data, uint64 dataSize, uint64 offset); // Update SSBO buffer data
		[LinkName("rlGetShaderBufferSize")]
		public static extern uint64 GetShaderBufferSize(uint32 id);                // Get SSBO buffer size
		[LinkName("rlReadShaderBufferElements")]
		public static extern void ReadShaderBufferElements(uint32 id, void* dest, uint64 count, uint64 offset);    // Bind SSBO buffer
		[LinkName("rlBindShaderBuffer")]
		public static extern void BindShaderBuffer(uint32 id, uint32 index);             // Copy SSBO buffer data

		// Buffer management
		[LinkName("rlCopyBuffersElements")]
		public static extern void CopyBuffersElements(uint32 destId, uint32 srcId, uint64 destOffset, uint64 srcOffset, uint64 count); // Copy SSBO buffer data
		[LinkName("rlBindImageTexture")]
		public static extern void BindImageTexture(uint32 id, uint32 index, uint32 format, int32 readonly_);  // Bind image texture

		// Matrix state management
		[LinkName("rlGetMatrixModelview")]
		public static extern Matrix GetMatrixModelview();                                  // Get internal modelview matrix
		[LinkName("rlGetMatrixProjection")]
		public static extern Matrix GetMatrixProjection();                                 // Get internal projection matrix
		[LinkName("rlGetMatrixTransform")]
		public static extern Matrix GetMatrixTransform();                                  // Get internal accumulated transform matrix
		[LinkName("rlGetMatrixProjectionStereo")]
		public static extern Matrix GetMatrixProjectionStereo(int32 eye);                        // Get internal projection matrix for stereo render (selected eye)
		[LinkName("rlGetMatrixViewOffsetStereo")]
		public static extern Matrix GetMatrixViewOffsetStereo(int32 eye);                        // Get internal view offset matrix for stereo render (selected eye)
		[LinkName("rlSetMatrixProjection")]
		public static extern void SetMatrixProjection(Matrix proj);                            // Set a custom projection matrix (replaces internal projection matrix)
		[LinkName("rlSetMatrixModelview")]
		public static extern void SetMatrixModelview(Matrix view);                             // Set a custom modelview matrix (replaces internal modelview matrix)
		[LinkName("rlSetMatrixProjectionStereo")]
		public static extern void SetMatrixProjectionStereo(Matrix right, Matrix left);        // Set eyes projection matrices for stereo rendering
		[LinkName("rlSetMatrixViewOffsetStereo")]
		public static extern void SetMatrixViewOffsetStereo(Matrix right, Matrix left);        // Set eyes view offsets matrices for stereo rendering

		// Quick and dirty cube/quad buffers load->draw->unload
		[LinkName("rlLoadDrawCube")]
		public static extern void LoadDrawCube();     // Load and draw a cube
		[LinkName("rlLoadDrawQuad")]
		public static extern void LoadDrawQuad();     // Load and draw a quad
	}
}