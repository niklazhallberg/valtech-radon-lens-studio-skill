# Code Node Reference Guide

This page serves as a reference for the special syntax decorations and system variables supported by Code Node in Material Editor and VFX Editor.

These lists can be found within the Code Node by selecting the appropriate snippet from the Example Code droplist.

For more information on the Code Node, check out the Code Node Guide.

![](/assets/images/code-node-reference-1-767f9ccacec9e91c19bc9680b9d1f358.png)

## Entrypoint[​**](#entrypoint "Copy to clipboard")

Code appearing in `main()` will be evaluated. The void `main(){}` function must exist in the code body for the material to compile:

```
​​input_vec4  Value1;
input_vec4  Value2;
output_vec4 Result;

void main()
{
    Result = Value1 * Value2;
}
```

## Extra Functions[​**](#extra-functions "Copy to clipboard")

Extra functions can be defined outside of `main()`. Inputs are available to use in extra functions without the need to be passed as arguments:

```
input_vec2 Input;
input_vec2 Bias;
output_vec2 Output;

vec2 myBiasFunction()
{
    return Input * 2.0 - 1.0 + Bias;
}

void main()
{
    Output = myBiasFunction();
}
```

## Input Types[​**](#input-types "Copy to clipboard")

Input ports are defined by the pattern: `input_[type] VariableName;`

```
input_int;
input_bool;
input_float;
input_vec2;
input_vec3;
input_vec4;
input_color3;
input_color4;
input_mat2;
input_mat3;
input_mat4;
input_texture_2d;
input_texture_2d_array;
input_texture_cube;
input_texture_3d;
input_float_array;
input_group;
input_droplist;
input_checkbox;
```

Droplists and Groups have special syntax following their VariableName that fills in strings for the droplist items and the group title, respectively:

```
input_droplist Droplist( "Item 1 : Item 2 : Item 3" );
input_group Group( "My Inputs" );
```

Droplists return const int values, and Checkboxes return const bool values.

## Output Types[​**](#output-types "Copy to clipboard")

Output ports follow a similar pattern: `output_[type] VariableName;`

For Code Nodes attached to VFX containers in the vertical stack (eg. the Spawn container), output ports can not be created.

These Code Nodes are intended to set particle attributes.

```
output_float;
output_vec2;
output_vec3;
output_vec4;
output_mat2;
output_mat3;
output_mat4;
```

## Global Types[​**](#global-types "Copy to clipboard")

Globals follow a similar pattern: `global_[type] VariableName;`

```
global_float;
global_vec2;
global_vec3;
global_vec4;
global_mat2;
global_mat3;
global_mat4;
```

## System Uniforms and Varyings[​**](#system-uniforms-and-varyings "Copy to clipboard")

Every system function has a node-based counterpart. A quick way to find documentation on a specific system function while in Lens Studio can be done by the following:

1. Create the Node version of the system you want.
2. Left-click the **i** at the top right corner of the node.
3. follow the link to the node’s full documentation page.

A complete list of system values can also be found by selecting the `System Built-In Values/Functions` snippet from the **Example Code** dropdown on the Code Node.

A note regarding random functions: the seed value should be within the range <0.0 to 1.0> to ensure a good random distribution. For VFX random functions, such as `getParticleRandomFloat()`, bool arguments allow for using ParticleID, NodeID, and/or Time as the basis for the seed. This is similar to the options found in the Seed drop-list on the Particle Random node. If you call this function multiple times in the same Code Node, with each call you will need to provide a different number in the range <0.0 to 1.0> for the final seed argument in order to return a unique random number.

```
vec3 system.getSurfacePosition()
vec3 system.getSurfacePositionObjectSpace()
vec3 system.getSurfacePositionWorldSpace()
vec3 system.getSurfacePositionCameraSpace()
vec4 system.getSurfacePositionScreenSpace()

vec3 system.getSurfaceNormal()
vec3 system.getSurfaceNormalFaceted()
vec3 system.getSurfaceNormalObjectSpace()
vec3 system.getSurfaceNormalWorldSpace()
vec3 system.getSurfaceNormalCameraSpace()

vec3 system.getSurfaceTangent()
vec3 system.getSurfaceTangentObjectSpace()
vec3 system.getSurfaceTangentWorldSpace()
vec3 system.getSurfaceTangentCameraSpace()

vec3 system.getSurfaceBitangent()
vec3 system.getSurfaceBitangentObjectSpace()
vec3 system.getSurfaceBitangentWorldSpace()
vec3 system.getSurfaceBitangentCameraSpace()

vec2 system.getSurfaceUVCoord0()
vec2 system.getSurfaceUVCoord1()

vec4 system.getSurfaceColor()

float system.getTimeElapsed()
float system.getTimeDelta()

vec2 system.getScreenUVCoord()

mat4 system.getMatrixProjectionViewWorldInverse()
mat4 system.getMatrixProjectionViewWorld()

mat4 system.getMatrixProjectionViewInverse()
mat4 system.getMatrixProjectionView()

mat4 system.getMatrixViewWorldInverse()
mat4 system.getMatrixViewWorld()

mat4 system.getMatrixWorldInverse()
mat4 system.getMatrixWorld()

mat4 system.getMatrixViewInverse()
mat4 system.getMatrixView()

mat4 system.getMatrixProjectionInverse()
mat4 system.getMatrixProjection()

mat4 system.getMatrixCamera()
mat4 system.getMatrixCameraInverse()

int   system.getDirectionalLightCount()
vec3  system.getDirectionalLightDirection( int index )
vec3  system.getDirectionalLightColor( int Index )
float system.getDirectionalLightIntensity( int Index )

int   system.getPointLightCount()
vec3  system.getPointLightPosition( int index )
vec3  system.getPointLightColor( int Index )
float system.getPointLightIntensity( int Index )

int   system.getAmbientLightCount()
vec3  system.getAmbientLightColor( int Index )
float system.getAmbientLightIntensity( int Index )

vec3 system.getCameraPosition()
vec3 system.getCameraForward()
vec3 system.getCameraRight()
vec3 system.getCameraUp()
float system.getCameraAspect()
float system.getCameraFOV()
float system.getCameraNear()
float system.getCameraFar()

vec3 system.getAABBMinLocal()
vec3 system.getAABBMaxLocal()
vec3 system.getAABBMinWorld()
vec3 system.getAABBMaxWorld()

int system.getInstanceCount()
int system.getInstanceID()
float system.getInstanceRatio()
int system.getNodeID()

float system.getHairStrandID()
vec4 system.getHairDebugColor()

float system.remap( float value, float oldMin, float oldMax, float newMin, float newMax )
vec2  system.remap( vec2 value, vec2 oldMin, vec2 oldMax, vec2 newMin, vec2 newMax )
vec3  system.remap( vec3 value, vec3 oldMin, vec3 oldMax, vec3 newMin, vec3 newMax )
vec4  system.remap( vec4 value, vec4 oldMin, vec4 oldMax, vec4 newMin, vec4 newMax )

vec2  system.pack16Bit( float value, float min, float max )
vec3  system.pack24Bit( float value, float min, float max )
vec4  system.pack32Bit( float value, float min, float max )
float system.unpack16Bit( vec2 value, float min, float max )
float system.unpack24Bit( vec3 value, float min, float max )
float system.unpack32Bit( vec4 value, float min, float max )

vec3 system.sampleEnvironmentSpecular( vec3 direction, float lod )
vec3 system.sampleEnvironmentDiffuse( vec3 direction )

vec3 system.linearToneMapping( vec3 color )
vec3 system.linearToSRGB( vec3 color )
vec3 system.SRGBToLinear( vec3 color )
void system.setPreviewColor( vec4 color ) // only works in pixel shader
float system.getRandomFloat( float/vec2/vec3/vec4 seed \<0.0 to 1.0> )
vec2 system.getRandomVec2( float/vec2/vec3/vec4 seed \<0.0 to 1.0> )
vec3 system.getRandomVec3( float/vec2/vec3/vec4 seed \<0.0 to 1.0> )
vec4 system.getRandomVec4( float/vec2/vec3/vec4 seed \<0.0 to 1.0> )

// VFX ONLY ( get particles attribute )

vec3 system.getParticlePosition()
vec3 system.getParticleVelocity()
float system.getParticleAge()
float system.getParticleLife()
vec3 system.getParticleForce()
float system.getParticleDelay()
float system.getParticleSeed()
float system.getParticleMass()
vec4 system.getParticleColor()
float system.getParticleSize()
int system.getParticleIndex()
float system.getParticleIndexRatio()
float system.getParticleAgeRatio()
mat4 system.getParticleMatrix()
bool system.getParticleSpawned()

// VFX ONLY ( get particles system settings )

int system.getParticleCount()
float system.getParticleMaxLife()
float system.getParticleSpawnRate()
float system.getParticleBurstRate()
vec3 system.getParticlePositionMin()
vec3 system.getParticlePositionMax()
vec3 system.getParticleVelocityMin()
vec3 system.getParticleVelocityMax()
float system.getParticleSizeMin()
float system.getParticleSizeMax()
vec4 system.getParticleColorMin()
vec4 system.getParticleColorMax()
float system.getParticleMassMin()
float system.getParticleMassMax()

// VFX ONLY ( get particles random values )

float system.getParticleRandomFloat( bool useParticleID, bool useNodeID, bool useTime, float extraSeed \<0.0 to 1.0> )
vec2 system.getParticleRandomVec2( bool useParticleID, bool useNodeID, bool useTime, float extraSeed \<0.0 to 1.0> )
vec3 system.getParticleRandomVec3( bool useParticleID, bool useNodeID, bool useTime, float extraSeed \<0.0 to 1.0> )
vec4 system.getParticleRandomVec4( bool useParticleID, bool useNodeID, bool useTime, float extraSeed \<0.0 to 1.0> )


// VFX ONLY ( set particles attributes - SPAWN/UPDATE stage only )

void system.killParticle()
void system.setParticlePosition( vec3 position )
void system.setParticleVelocity( vec3 velocity )
void system.setParticleLife( float life )
void system.setParticleForce( vec3 force )
void system.setParticleMass( float mass )
void system.setParticleColor( vec4 color )
void system.setParticleSize( float size )
void system.setParticleMatrix( mat4 matrix )

// VFX ONLY ( set vertex attributes - OUTPUT stage only - vertex stage only )

void system.setVertexPosition( vec3 position )
void system.setVertexNormal( vec3 normal )
void system.setVertexTangent( vec3 tangent )

// VFX ONLY ( set particles attributes - OUTPUT stage only - pixel stage only )

void system.setPixelColor0( vec4 color )
void system.setPixelColor1( vec4 color )
void system.setPixelColor2( vec4 color )
void system.setPixelColor3( vec4 color )
void system.setPixelDepth( float depth )
```

Show more▼
